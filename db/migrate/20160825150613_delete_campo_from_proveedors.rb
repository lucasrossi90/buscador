class DeleteCampoFromProveedors < ActiveRecord::Migration
  def change
  	remove_column :proveedors, :proveedor_id
  end
end
