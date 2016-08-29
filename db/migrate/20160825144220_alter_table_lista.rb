class AlterTableLista < ActiveRecord::Migration
  def change
  	rename_column :lista, :proveedor, :proveedor_id
  end
end
