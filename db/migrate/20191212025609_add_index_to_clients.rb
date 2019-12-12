class AddIndexToClients < ActiveRecord::Migration[6.0]
  def change
  	add_column :clients, :first_name, :string
    add_column :clients, :last_name, :string
    add_column :clients, :adresse, :string
    add_column :clients, :tel, :string
  end
end
