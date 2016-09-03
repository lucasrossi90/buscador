class AddDescuentoToListum < ActiveRecord::Migration
  def change
  	add_column :lista, :descuento, :int
  end
end
