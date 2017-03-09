class ArticulosController < ApplicationController
	# require 'spreadsheet'
	# Spreadsheet.client_encoding = 'UTF-8'

	def new
		@articulo = Articulo.new
	end

	def index
		@proveedores = Proveedor.all.order('nombre')
	end

  def upload
    @listas = Listum.all.includes(:proveedor).order('nombre')
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


  		if @lista.proveedor.nombre == 'DISTRIBUIDORA OK'
           
        crear_articulos_descuento(@lista, book, nro_lista)

      elsif @lista.proveedor.nombre == 'HERTRAC'

        crear_articulos_punto(@lista, book, nro_lista)

      elsif @lista.proveedor.nombre == 'DE-FA'

        crear_articulos_coma(@lista, book, nro_lista)
           
      elsif @lista.nombre == 'CACY - DIESEL'        
        
        crear_articulos(@lista, book, nro_lista,  0)
        crear_articulos(@lista, book, nro_lista,  4)

      elsif @lista.nombre == 'FPM'

        crear_articulos(@lista, book, nro_lista, 0)
        crear_articulos(@lista, book, nro_lista, 3)
        crear_articulos(@lista, book, nro_lista, 6)
        crear_articulos(@lista, book, nro_lista, 9)

      else

        crear_articulos(@lista, book, nro_lista, 0)

      end
    end

        render(
        html: "<script>alert('Lista subida')</script>".html_safe,
        layout: 'application'
        )
  end

  def crear_articulos_descuento(lista, book, nro_lista)
    pages = @lista.hoja["paginas"]
      pages.each do |page|
        book.sheet(page).each do |row|
        codigo = row[@lista.codigo]
        precio = row[@lista.precio]
        descuento = row[@lista.descuento]
        next unless codigo.present?
        next unless precio.present?
        next unless descuento.present?    
        @lista.articulos.create(
                  codigo:row[@lista.codigo], 
                  descripcion:row[@lista.descripcion], 
                  precio:row[@lista.precio], 
                  rubro: @lista.rubro,
                  descuento: row[@lista.descuento],
                  listum_id: nro_lista)
        end
      end
  end

    def crear_articulos_punto(lista, book, nro_lista)
    pages = @lista.hoja["paginas"]
      pages.each do |page|
        book.sheet(page).each do |row|
        codigo = row[@lista.codigo]
        precio = row[@lista.precio]
        next unless codigo.present?
       
          if precio.blank?

            @lista.articulos.create(
                      codigo:row[@lista.codigo].gsub(/\s/,''), 
                      descripcion:row[@lista.descripcion], 
                      precio: 0, 
                      rubro: @lista.rubro,
                      descuento: @lista.proveedor.descuento,
                      listum_id: nro_lista)
          else

            @lista.articulos.create(
                    codigo:row[@lista.codigo].gsub(/\s/,''), 
                    descripcion:row[@lista.descripcion], 
                    precio: row[@lista.precio].gsub(/\./,''), 
                    rubro: @lista.rubro,
                    descuento: @lista.proveedor.descuento,
                    listum_id: nro_lista)
          end
        end
      end
  end

  def crear_articulos_coma(lista, book, nro_lista)
    pages = @lista.hoja["paginas"]
      pages.each do |page|
        book.sheet(page).each do |row|
        codigo = row[@lista.codigo]
        precio = row[@lista.precio]
        next unless codigo.present?
       
          if precio.blank?

            @lista.articulos.create(
                      codigo:row[@lista.codigo], 
                      descripcion:row[@lista.descripcion], 
                      precio: 0, 
                      rubro: @lista.rubro,
                      descuento: @lista.proveedor.descuento,
                      listum_id: nro_lista)
          else

            @lista.articulos.create(
                    codigo:row[@lista.codigo], 
                    descripcion:row[@lista.descripcion], 
                    precio: row[@lista.precio].gsub(/\,/, '').tr('.',','), 
                    rubro: @lista.rubro,
                    descuento: @lista.proveedor.descuento,
                    listum_id: nro_lista)
          end
        end
      end
  end

  def crear_articulos(lista, book, nro_lista, offset)
    pages = @lista.hoja["paginas"]
      pages.each do |page|
        book.sheet(page).each do |row|
        codigo = row[@lista.codigo + offset]
        descripcion = row[@lista.descripcion + offset]
        precio = row[@lista.precio + offset]
        next unless codigo.present?

          if precio.blank?

            @lista.articulos.create(
                      codigo:row[@lista.codigo + offset], 
                      descripcion:row[@lista.descripcion + offset], 
                      precio: 0, 
                      rubro: @lista.rubro,
                      descuento: @lista.proveedor.descuento,
                      listum_id: nro_lista)
          else

            @lista.articulos.create(
                    codigo:row[@lista.codigo + offset], 
                    descripcion:row[@lista.descripcion + offset], 
                    precio:row[@lista.precio + offset], 
                    rubro: @lista.rubro,
                    descuento: @lista.proveedor.descuento,
                    listum_id: nro_lista)
          end
        end
      end
  end

  def mostrar_lista
      @listas = Listum.all.order('nombre')
  end

  def articulos_lista
    if params[:lista]
     @articulos_lista = Articulo.where(listum_id: params[:lista]).order(params[:orden_lista])
    end
    render @articulos_lista
  end

end     



