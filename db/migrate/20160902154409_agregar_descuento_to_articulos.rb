class AgregarDescuentoToArticulos < ActiveRecord::Migration
  def change
  	add_column :articulos, :descuento, :int
  end
end
