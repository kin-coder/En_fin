class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.float :price
      t.belongs_to :service, index:true
      
      t.timestamps
    end
  end
end
