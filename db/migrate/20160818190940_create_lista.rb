class CreateLista < ActiveRecord::Migration
  def change
    create_table :lista do |t|

      t.timestamps null: false
    end
  end
end
