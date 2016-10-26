class Articulo < ActiveRecord::Base
  belongs_to :listum
	
	def self.search(descripcion, proveedor = nil)
		query = where("(articulos.codigo ILIKE ? OR articulos.descripcion ILIKE ?)", "%#{descripcion}%", "%#{descripcion}%")
    if proveedor.present?
      query = query.joins(:listum).where('lista.proveedor_id = ?', proveedor)
    end
    query.includes(:listum)
	end

end

