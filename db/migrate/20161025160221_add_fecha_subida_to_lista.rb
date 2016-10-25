class AddFechaSubidaToLista < ActiveRecord::Migration
  def change
  	add_column :lista, :fecha_subida, :datetime
  end
end
