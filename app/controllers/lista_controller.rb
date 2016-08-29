class ListaController < ApplicationController

	def index
    @listas = Lista.all
	end

end
