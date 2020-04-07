class AddIndexToPrestataires < ActiveRecord::Migration[6.0]
  def change
		add_column :prestataires, :sexe, :string
	  add_column :prestataires, :first_name, :string
	  add_column :prestataires, :last_name, :string
	  add_column :prestataires, :date_of_birth, :string
	  add_column :prestataires, :raison_sociale, :string
	  add_column :prestataires, :siren, :string
	  add_column :prestataires, :tel, :string
	  add_column :prestataires, :adresse, :string
	  add_column :prestataires, :zip_code, :string
	  add_column :prestataires, :ville, :string
	  add_column :prestataires, :pays, :string
	  # t.string :services #spa | massage || coiffure
	  # t.string :countries #spa | France || Suisse
	  # t.string :departments
  end
  # def change
  #   add_column :prestataires, :first_name, :string
  #   add_column :prestataires, :last_name, :string
  #   add_column :prestataires, :adresse, :string
  #   add_column :prestataires, :tel, :string
  #   add_column :prestataires, :raison_sociale, :string
  #   add_column :prestataires, :siret, :string
  # end
end
