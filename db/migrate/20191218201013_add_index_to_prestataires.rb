class AddIndexToPrestataires < ActiveRecord::Migration[6.0]
  def change
    add_column :prestataires, :first_name, :string
    add_column :prestataires, :last_name, :string
    add_column :prestataires, :adresse, :string
    add_column :prestataires, :tel, :string
    add_column :prestataires, :raison_sociale, :string
    add_column :prestataires, :siren, :string
  end
end
