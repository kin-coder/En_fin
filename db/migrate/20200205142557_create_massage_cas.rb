class CreateMassageCas < ActiveRecord::Migration[6.0]
  def change
    create_table :massage_cas do |t|
      t.string :name
      t.belongs_to :service, index:true
      
      t.timestamps
    end
  end
end
