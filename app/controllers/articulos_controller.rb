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
		@lista = Lista.find(nro_lista)
    ActiveRecord::Base.transaction do
      if @lista.articulos.any?
        @lista.articulos.destroy_all
      end
  		subido = params[:file]
  		contenido = subido.read
  		book = Spreadsheet.open(StringIO.new(contenido))
  		sheet = book.worksheet(@lista.hoja)
  		sheet.each do |row|
        @lista.articulos.create(
                codigo:row[@lista.cod], 
  							desc:row[@lista.desc], 
  							precio:row[@lista.precio], 
  							proveedor: @lista.proveedor_id, 
  							rubro:row[@lista.rubro], 
  							fecha_precio: Date.today)
      end
  	end
    render text: 'Listo'
  end

  def upload
  	@listas = Listum.all
  	end
end
