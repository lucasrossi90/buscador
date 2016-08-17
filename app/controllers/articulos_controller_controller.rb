class ArticulosControllerController < ApplicationController
	def index
	  @articulos = Articulo.search(params[:search])
	end
end
