class CambiarCampoEnLista < ActiveRecord::Migration
  def change
  	rename_column :lista, :desc, :descripcion
  end
end
