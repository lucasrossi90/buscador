class ArticulosController < ApplicationController
	# require 'spreadsheet'
	# Spreadsheet.client_encoding = 'UTF-8'

	def new
		@articulo = Articulo.new
	end

	def index
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
		subido = params[:file]
		contenido = subido.read
		book = Spreadsheet.open(StringIO.new(contenido))
    # byebug
		sheet = book.worksheet(0)
		sheet.each do |row|
			Articulo.create(codigo:row[0], 
							desc:row[1], 
							precio:row[2], 
							proveedor:'CDC', 
							rubro:row[6], 
							fecha_precio: Date.today,
							id_lista: 1)
		end
    render text: 'Listo'
  end

  def upload
  	@listas = Listum.all
  	end
end
