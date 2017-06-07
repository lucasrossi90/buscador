class ProductoSerializer < ActiveModel::Serializer
  attributes  :descripcion,
  			  :rubro,
    		  :articulos,
    		  :codigo_interno,
    		  :codigo_original,
   			  :ubicacion
end
