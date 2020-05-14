class CreateMassageMassageTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :massage_massage_types do |t|
    	t.belongs_to :massage
			t.belongs_to :massage_type
      t.timestamps
    end
  end
end
