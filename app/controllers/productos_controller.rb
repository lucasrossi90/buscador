class ProductosController < ApplicationController

	def index
		@productos = Producto.all
	end
	
	def resultado_productos
	    if params[:interno]
	   		@producto = Producto.search_interno(params[:interno])
	    elsif params[:search]
	      	@productos = Producto.search(params[:search], params[:rubro], params[:orden], params[:page])     
	    else
	      	@productos = Producto.all
	    end
	      render json: @articulos
  	end
end
