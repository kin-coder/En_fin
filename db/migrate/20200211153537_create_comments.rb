class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :note
      t.text :content
      t.string :user_name
      t.string :comment_for
      t.timestamps
    end
  end
end
