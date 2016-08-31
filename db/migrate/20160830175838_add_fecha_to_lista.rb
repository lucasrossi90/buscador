class AddFechaToLista < ActiveRecord::Migration
  def change
  	add_column :lista, :fecha_precio, :datetime
  end
end
