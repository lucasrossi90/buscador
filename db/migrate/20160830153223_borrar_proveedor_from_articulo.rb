class BorrarProveedorFromArticulo < ActiveRecord::Migration
  def change
  	remove_column :articulos, :proveedor
  end
end
