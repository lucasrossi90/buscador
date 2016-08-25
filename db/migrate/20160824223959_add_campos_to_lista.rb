class AddCamposToLista < ActiveRecord::Migration
  def change
    add_column :lista, :nombre, :string
    add_column :lista, :proveedor, :string
  end
end
