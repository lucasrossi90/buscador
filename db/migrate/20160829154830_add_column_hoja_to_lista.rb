class AddColumnHojaToLista < ActiveRecord::Migration
  def change
    add_column :lista, :hoja, :int
  end
end
