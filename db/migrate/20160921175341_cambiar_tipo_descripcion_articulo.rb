class CambiarTipoDescripcionArticulo < ActiveRecord::Migration
  def change
  	remove_column :articulos, :descripcion
  	add_column :articulos, :descripcion, :string
  end
end
