class CambiarCampoEnArticulos < ActiveRecord::Migration
  def change
  	rename_column :articulos, :desc, :descripcion
  end
end
