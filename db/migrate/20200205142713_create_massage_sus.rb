class CreateMassageSus < ActiveRecord::Migration[6.0]
  def change
    create_table :massage_sus do |t|
      t.string :name
      t.text :description
      t.belongs_to :massage_ca, index:true
      
      t.timestamps
    end
  end
end
