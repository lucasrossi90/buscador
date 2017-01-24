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
		(object.listum.fecha_precio).strftime('%m/%Y')
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

	def precio
		object.precio.round(2)
	end

	def codigo
		if object.listum.proveedor.nombre == 'DIVALCOR' || 'BOETTO'
			object.codigo.gsub(/\.0\Z/, '')
		else
			object.codigo
		end	
	end

end
