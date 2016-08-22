class Articulo < ActiveRecord::Base
	
	def self.search(search)
		where("codigo LIKE ?", "%#{search}%") 
	end

end

