class ListaController < ApplicationController
	
	def new
		@listum = Lista.new
	end

	def upload
	end

	def index
	end

	def create
	  @listum = Lista.new(listum_params)

	    if @listum.save
          redirect_to articulos_path, notice: "La lista ha sigo cargada."
    	else
          render "new"
        end
      
      end
	

	private
      def listum_params
      params.require(:lista, :proveedor, :mes).permit(:attachment, :rubro)
    end

end
