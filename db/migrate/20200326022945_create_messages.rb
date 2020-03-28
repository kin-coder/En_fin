class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :tel
      t.string :name_corp
      t.text :content
      t.boolean :is_see, default: :false

      t.timestamps
    end
  end
end

# Besoin D’infos ? (acceuil fait - massage - location spa devenir - partenaire - contact - faq -  )
# save_message_path