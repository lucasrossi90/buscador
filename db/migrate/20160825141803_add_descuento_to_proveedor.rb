class AddDescuentoToProveedor < ActiveRecord::Migration
  def change
    add_column :proveedors, :desc, :int
  end
end
