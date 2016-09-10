class ArticulosController < ApplicationController
	# require 'spreadsheet'
	# Spreadsheet.client_encoding = 'UTF-8'

	def new
		@articulo = Articulo.new
	end

	def index
		@proveedores = Proveedor.all
	end

  def resultado_articulos
    if params[:search]
      @articulos = Articulo.search(params[:search], params[:proveedor])
    else
      @articulos = Articulo.all
    end
    render layout: false
  end

  def import_excel
	  nro_lista = params[:lista]
	  @lista = Listum.find(nro_lista)
    @lista.fecha_precio = Date.today
    @lista.save
    ActiveRecord::Base.transaction do
      
      destruir_existentes (@lista)

      subido = params[:file]
      contenido = subido.read
      book = Spreadsheet.open(StringIO.new(contenido))
      sheet = book.worksheet(@lista.hoja)

  		if @lista.nombre == 'DISTRIBUIDORA OK'
           
        insertar_oka (@lista, sheet)
           
      else
        
        insertar_demas (@lista, sheet)

      end
        render(
        html: "<script>alert('Lista subida')</script>".html_safe,
        layout: 'application'
        )
        redirect_to upload_path
    end
  

  def upload
  	@listas = Listum.all
  end

  def destruir_existentes (lista)
     if @lista.articulos.any?
        @lista.articulos.destroy_all
      end
  end 


  def insertar_oka (lista, sheet)
    sheet = book.worksheet(@lista.hoja)     
    sheet.each do |row|
    @lista.articulos.create(
              codigo:row[@lista.cod], 
              desc:row[@lista.desc], 
              precio:row[@lista.precio], 
              rubro: @lista.rubro,
              descuento: row[@lista.descuento],
              listum_id: nro_lista)
    end
  end

  def insertar_demas (lista, sheet)    
    sheet.each do |row|
    @lista.articulos.create(
                  codigo:row[@lista.cod], 
                  desc:row[@lista.desc], 
                  precio:row[@lista.precio], 
                  rubro: @lista.rubro,
                  descuento: @lista.proveedor.desc, 
                  listum_id: nro_lista)
    end
  end

  
end     



