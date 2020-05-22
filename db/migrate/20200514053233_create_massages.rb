class CreateMassages < ActiveRecord::Migration[6.0]
  def change
    create_table :massages do |t|
      t.string :name
      t.belongs_to :service, index:true

      t.timestamps
    end
  end
end
