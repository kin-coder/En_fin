class CreateCodePromos < ActiveRecord::Migration[6.0]
  def change
    create_table :code_promos do |t|
      t.string :code
      t.float :reduction

      t.timestamps
    end
  end
end
