class Producto < ActiveRecord::Base
	
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

	def self.search_interno(interno)
		query = where("(productos.codigo_interno == ?)", "%#{interno}%")
	end

	def self.search_codigodesc(codigodesc, rubro = nil, orden, page)
		query = where("(productos.codigo_original ILIKE ? OR productos.descripcion ILIKE ?)", 
			"%#{codigodesc}%", "%#{codigodesc}%").order(orden).limit(50).offset((page.to_i) * 50)
		if rubro.present?
      		query = query.joins(:rubro).where('productos.rubro = ?', rubro)
    	end
	end


end
