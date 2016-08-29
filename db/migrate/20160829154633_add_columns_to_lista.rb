class AddColumnsToLista < ActiveRecord::Migration
  def change
    add_column :lista, :rubro, :string
  end
end
