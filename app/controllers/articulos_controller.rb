class ArticulosController < ApplicationController
	require 'spreadsheet'
	Spreadsheet.client_encoding = 'UTF-8'

	def new
		@articulo = Articulo.new
	end

	def index
	  if params[:search]
	    @articulos = Articulo.search(params[:search])
	  else
	    @articulos = Articulo.all
	  end
	end

	def upload
		require 'spreadsheet'
		Spreadsheet.client_encoding = 'UTF-8'
		subido = params[:file]
		contenido = subido.read
		book = Spreadsheet.open(StringIO.new(contenido))
		sheet1 = book.worksheet(2)
				sheet.each do |row|
					Articulo.create(codigo:row[0], 
									descripcion:row[1], 
									precio:row[2], 
									proveedor:'CDC', 
									rubro:row[6], 
									fecha_precio:datetime,
									id_lista: 1)
				end  		
	end

end
