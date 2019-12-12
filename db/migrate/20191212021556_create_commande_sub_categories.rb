class CreateCommandeSubCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :commande_sub_categories do |t|
      t.belongs_to :commande_category, index:true
      t.belongs_to :subcategory, index:true
      
      t.timestamps
    end
  end
end
