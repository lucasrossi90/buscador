class Producto < ActiveRecord::Base
	has_many :articulos

	 def cargar_productos
		book = Roo::Spreadsheet.open('PRODUCTOS.xls')
		book.sheet(0).each do |row|
		Producto.create(
              codigo_interno:row[0], 
              codigo_original:row[3], 
              rubro: row[2],
              ubicacion: row[4],
              descripcion: row[1])
	    end
	end

	def self.search(descripcion, rubro = nil, orden, page)
		query = where("(articulos.codigo ILIKE ? OR articulos.descripcion ILIKE ?)", 
			"%#{descripcion}%", "%#{descripcion}%").order(orden).limit(50).offset((page.to_i) * 50)
    if proveedor.present?
      query = query.joins(:listum).where('lista.proveedor_id = ?', proveedor)
    end
    query.includes(:listum)
	end

	def self.search(descripcion, rubro = nil, orden, page)
		query = where("(articulos.codigo ILIKE ? OR articulos.descripcion ILIKE ?)", 
			"%#{descripcion}%", "%#{descripcion}%").order(orden).limit(50).offset((page.to_i) * 50)
    if proveedor.present?
      query = query.joins(:listum).where('lista.proveedor_id = ?', proveedor)
    end
    query.includes(:listum)
	end


end
