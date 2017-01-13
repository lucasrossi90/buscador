class ArticulosController < ApplicationController
	# require 'spreadsheet'
	# Spreadsheet.client_encoding = 'UTF-8'

	def new
		@articulo = Articulo.new
	end

	def index
		@proveedores = Proveedor.all
	end

  def upload
    @listas = Listum.all.includes(:proveedor)
  end

  def destruir_existentes(lista)
     if @lista.articulos.any?
        @lista.articulos.destroy_all
     end
  end 

  def resultado_articulos
    if params[:search]
      @articulos = Articulo.search(params[:search], params[:proveedor], params[:orden], params[:page])     
    else
      @articulos = Articulo.all
    end
      render json: @articulos
  end

  def import_excel
	  nro_lista = params[:lista]
    fecha_lista = params[:fecha]
    fecha_parse = Date.parse(fecha_lista)
 	  @lista = Listum.find(nro_lista)
    @lista.fecha_precio = fecha_parse
    @lista.fecha_subida = DateTime.now
    @lista.save
    ActiveRecord::Base.transaction do
      
      destruir_existentes(@lista)

      book = Roo::Spreadsheet.open(params[:file].path)


  		if @lista.nombre == 'DISTRIBUIDORA OK'
           
        insertar_oka(@lista, book, nro_lista)
           
      else        
        
        insertar_demas(@lista, book, nro_lista)

      end
    end

        render(
        html: "<script>alert('Lista subida')</script>".html_safe,
        layout: 'application'
        )
  end

  def insertar_demas(lista, book, nro_lista)
    book.sheet(@lista.hoja).each do |row|
    codigo = row[@lista.codigo]
    precio = row[@lista.precio]
    next unless codigo.present?
    next unless precio.present?
    @lista.articulos.create(
                codigo: row[@lista.codigo], 
                descripcion: row[@lista.descripcion], 
                precio: row[@lista.precio], 
                rubro: @lista.rubro,
                descuento: @lista.proveedor.descuento, 
                listum_id: nro_lista)
    end
  end
  

  def insertar_oka(lista, book, nro_lista)
    book.sheet(@lista.hoja).each do |row|
    codigo = row[@lista.codigo]
    next unless codigo.present?
    @lista.articulos.create(
              codigo:row[@lista.codigo], 
              descripcion:row[@lista.descripcion], 
              precio:row[@lista.precio], 
              rubro: @lista.rubro,
              descuento: row[@lista.descuento],
              listum_id: nro_lista)
    end
  end

  def mostrar_lista
      @listas = Listum.all
  end

  def articulos_lista
    if params[:lista]
     @articulos_lista = Articulo.where(listum_id: params[:lista]).order(params[:orden_lista])
    end
    render @articulos_lista
  end

end     



