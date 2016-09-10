class CambiarCampoCodEnLista < ActiveRecord::Migration
  def change
  	rename_column :lista, :cod, :codigo
  end
end
