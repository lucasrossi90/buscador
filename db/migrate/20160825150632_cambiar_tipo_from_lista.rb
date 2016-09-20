class CambiarTipoFromLista < ActiveRecord::Migration
  def change
  	remove_column :lista, :proveedor_id
  	add_column :lista, :proveedor_id, :int
  end
end
