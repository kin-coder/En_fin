class CreateCommandes < ActiveRecord::Migration[6.0]
  def change
    create_table :commandes do |t|
      t.belongs_to :client, index:true
      t.belongs_to :service, index:true
      
      t.timestamps
    end
  end
end
