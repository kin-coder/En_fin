class CreateSpaAmbiances < ActiveRecord::Migration[6.0]
  def change
    create_table :spa_ambiances do |t|
      t.string :name
      t.text :description
      t.float :price
      t.timestamps
    end
  end
end
