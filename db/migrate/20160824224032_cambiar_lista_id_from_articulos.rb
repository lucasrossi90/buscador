class CambiarListaIdFromArticulos < ActiveRecord::Migration
  def change
  	rename_column :articulos, :id_lista, :listum_id
  end
end
