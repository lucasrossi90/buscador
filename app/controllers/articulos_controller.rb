class ArticulosController < ApplicationController
	def index
	  @articulos = Articulo.search(params[:search])
	end
end
