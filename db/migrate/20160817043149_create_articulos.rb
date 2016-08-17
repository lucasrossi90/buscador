class CreateArticulos < ActiveRecord::Migration
  def change
    create_table :articulos do |t|
      t.string :codigo
      t.text :desc
      t.decimal :precio
      t.string :proveedor
      t.string :rubro
      t.date :fecha_precio

      t.timestamps null: false
    end
  end
end
