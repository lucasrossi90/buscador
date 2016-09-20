class DeleteFechaFromArticulo < ActiveRecord::Migration
  def change
  	remove_column :articulos, :fecha_precio
  end
end
