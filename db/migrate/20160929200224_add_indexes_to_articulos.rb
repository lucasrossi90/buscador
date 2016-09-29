class AddIndexesToArticulos < ActiveRecord::Migration
  def change
    add_index :articulos, [:codigo, :descripcion, :listum_id]
  end
end
