class AddIndexToClients < ActiveRecord::Migration[6.0]
	def change
		add_column :clients, :first_name, :string
		add_column :clients, :last_name, :string
		add_column :clients, :adresse, :string
		add_column :clients, :adresse_complet, :string
		add_column :clients, :tel, :string
		add_column :clients, :sexe, :string
		add_column :clients, :country, :string
		add_column :clients, :zip_code, :string
		add_column :clients, :town, :string
		add_column :clients, :is_client, :boolean, default:false
	end
end
