class Producto < ActiveRecord::Base
	
	 def cargar_productos
		book = Roo::Spreadsheet.open('/home/lucas/PRODUCTOS.xls')
		book.sheet(0).each do |row|
		Producto.create(
              codigo_interno:row[0], 
              codigo_original:row[3], 
              rubro: row[2],
              ubicacion: row[4],
              descripcion: row[1])
	    end
	end

	def borrar_blancos
		productos = Producto.all
		productos.each do |p| 
			p.codigo_interno = p.codigo_interno.gsub!(/\s+/, '')
			p.codigo_original = p.codigo_original.gsub!(/\s+/, '')
			p.descripcion = p.descripcion.gsub!(/\s+/, '')
			p.ubicacion= p.ubicacion.gsub!(/\s+/, '')
			p.rubro = p.rubro.gsub!(/\s+/, '')
			p.save
		end
	end

	def self.search_interno(interno)
		query = where('productos.codigo_interno = ?', interno)
	end

	def self.search_codigodesc(codigodesc, rubro = nil, orden, page)
		query = where("(productos.codigo_original ILIKE ? OR productos.descripcion ILIKE ?)", 
			"%#{codigodesc}%", "%#{codigodesc}%").order(orden).limit(50).offset((page.to_i) * 50)
		if rubro.present?
      		query = where('productos.rubro = ?', rubro)
    	end
    	query
	end


end
