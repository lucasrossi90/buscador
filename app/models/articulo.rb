class Articulo < ActiveRecord::Base
	
	def self.search(search)
		where("codigo LIKE ? OR desc LIKE ?", "%#{search}%", "%#{search}%")
	end

end

