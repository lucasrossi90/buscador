class Articulo < ActiveRecord::Base
	
	def self.search(descripcion, proveedor = nil)
		query = where("(codigo LIKE ? OR desc LIKE ?)", "%#{descripcion}%", "%#{descripcion}%")
    if proveedor.present?
      query = query.where(proveedor: proveedor)
    end
    query
	end

end

