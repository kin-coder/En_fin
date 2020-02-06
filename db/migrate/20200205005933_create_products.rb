class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.boolean :is_option_spa, default: :false
      
      t.timestamps
    end
  end
end
