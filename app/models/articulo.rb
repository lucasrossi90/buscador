class Articulo < ActiveRecord::Base
  belongs_to :listum
  belongs_to :producto
	
	def self.search(descripcion, proveedor = nil, orden, page)
		query = where("(articulos.codigo ILIKE ? OR articulos.descripcion ILIKE ?)", 
			"%#{descripcion}%", "%#{descripcion}%").order(orden).limit(50).offset((page.to_i) * 50)
    if proveedor.present?
      query = query.joins(:listum).where('lista.proveedor_id = ?', proveedor)
    end
    query.includes(:listum)
	end

end

