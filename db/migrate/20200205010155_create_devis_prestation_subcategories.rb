class CreateDevisPrestationSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :devis_prestation_subcategories do |t|
      t.belongs_to :subcategory
	  t.belongs_to :devis_prestation
      t.timestamps
    end
  end
end
