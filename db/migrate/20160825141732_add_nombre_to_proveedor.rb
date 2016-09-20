class AddNombreToProveedor < ActiveRecord::Migration
  def change
    add_column :proveedors, :nombre, :string
  end
end
