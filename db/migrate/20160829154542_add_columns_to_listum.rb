class AddColumnsToListum < ActiveRecord::Migration
  def change
    add_column :lista, :cod, :int
    add_column :lista, :desc, :int
    add_column :lista, :precio, :int
  end
end
