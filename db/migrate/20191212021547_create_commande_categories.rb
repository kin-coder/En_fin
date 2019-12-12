class CreateCommandeCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :commande_categories do |t|
      t.belongs_to :category, index:true
      t.belongs_to :commande, index:true
      
      t.timestamps
    end
  end
end
