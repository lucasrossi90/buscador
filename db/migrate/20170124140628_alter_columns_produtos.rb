class AlterColumnsProdutos < ActiveRecord::Migration
  def change
  	remove_column :productos, :codigo
  	add_column :productos, :codigo_interno, :string
  	add_column :productos, :codigo_original, :string
  	add_column :productos, :ubicacion, :string
  end
end
