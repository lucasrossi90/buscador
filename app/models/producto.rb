class Producto < ActiveRecord::Base
	has_many :articulos

	def parse_productos
		product_array = []

		product.split("\n").each do |product_line|
	    product_array << product_line.split(" ")
		end
	end

end
