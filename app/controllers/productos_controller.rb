class ProductosController < ApplicationController

	def new
		@producto = Producto.new
	end

	def index
		@rubros = Rubro.all
	end

	def edit
		@producto = Producto.where(params[:codigo_interno])
	end

	def resultado_productos
		if params[:interno]
	   		@productos = Producto.search_interno(params[:interno])
	    elsif params[:codigodesc]
	    	@productos = Producto.search_codigodesc(params[:codigodesc], params[:rubro], params[:orden], params[:page])
	    else
	      	@productos = Producto.all
	    end
	      render json: @productos
  	end
end
