class AlterColumnHojaFromLista < ActiveRecord::Migration
  def change
  	remove_column :lista, :hoja 
  	add_column :lista, :hoja, :json
  end
end
