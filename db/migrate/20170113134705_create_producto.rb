class CreateProducto < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :codigo
      t.string :descripcion
      t.string :rubro
      t.text :articulos
    end
  end
end
