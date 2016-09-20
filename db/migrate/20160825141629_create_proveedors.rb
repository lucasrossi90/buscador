class CreateProveedors < ActiveRecord::Migration
  def change
    create_table :proveedors do |t|

      t.timestamps null: false
    end
  end
end
