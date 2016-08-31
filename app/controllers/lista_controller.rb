class ListaController < ApplicationController

	def index
      @listas = Listum.all
	end

end
