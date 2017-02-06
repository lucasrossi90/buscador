class Rubro < ActiveRecord::Base

	def cargar_rubros
		@rubros = Producto.distinct.pluck(:rubro)
		@rubros.each do |rubro|
			Rubro.create(
				rubro.nombre = rubro)
		end
	end
end
