class CreateSpaSpaAmbiances < ActiveRecord::Migration[6.0]
  def change
    create_table :spa_spa_ambiances do |t|
    	t.belongs_to :spa
			t.belongs_to :spa_ambiance
      t.timestamps
    end
  end
end
