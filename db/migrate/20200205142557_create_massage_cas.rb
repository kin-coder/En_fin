class CreateMassageCas < ActiveRecord::Migration[6.0]
  def change
    create_table :massage_cas do |t|
      t.string :name

      t.timestamps
    end
  end
end
