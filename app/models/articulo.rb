class Articulo < ActiveRecord::Base
	belongs_to :listum
	
	def self.search(descripcion, proveedor = nil)
		query = where("(codigo LIKE ? OR descripcion LIKE ?)", "%#{descripcion}%", "%#{descripcion}%")
    if proveedor.present?
      query = query.where(proveedor: proveedor)
    end
    query.includes(:listum)
	end

end

