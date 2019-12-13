class CreatePrestataires < ActiveRecord::Migration[6.0]
  def change
    create_table :prestataires do |t|

      t.timestamps
    end
  end
end
