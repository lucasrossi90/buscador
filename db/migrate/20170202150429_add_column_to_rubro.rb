class AddColumnToRubro < ActiveRecord::Migration
  def change
  	add_column :rubros, :nombre, :string
  end
end
