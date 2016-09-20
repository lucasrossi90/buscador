class CambiarCampoEnProveedors < ActiveRecord::Migration
  def change
  	rename_column :proveedors, :desc, :descuento
  end
end
