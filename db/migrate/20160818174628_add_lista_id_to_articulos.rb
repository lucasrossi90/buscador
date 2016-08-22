class AddListaIdToArticulos < ActiveRecord::Migration
  def change
    add_column :articulos, :id_lista, :int
  end
end
