class ProductosController < ApplicationController

	def index
		@productos = Producto.all
	end
	
end
