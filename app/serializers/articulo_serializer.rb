class ArticuloSerializer < ActiveModel::Serializer
  attributes :id, 
			  :codigo, 
			  :descripcion, 
			  :precio, 
			  :precioDescuento, 
			  :precioIva, 
			  :nombreLista, 
			  :descuento, 
			  :rubro,
			  :fechaLista

	belongs_to :listum

	def fechaLista
		(object.listum.fecha_precio).strftime('%Y/%m')
	end

	def precioDescuento
		(object.precio - ((object.precio * object.descuento)/100)).round(2)
	end

	def precioIva
		(((object.precio - ((object.precio * object.descuento)/100)) * 1.21).round(2))
	end

	def nombreLista
		object.listum.nombre
	end

end
