class AlterColumnArticulosFromProducto < ActiveRecord::Migration
  def change
  	remove_column :productos, :articulos
  	add_column :productos, :articulos, :json
  end
end
