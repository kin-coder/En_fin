class CreatePrestataireDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :prestataire_departments do |t|
      t.belongs_to :department, index:true
      t.belongs_to :prestataire, index:true
      t.timestamps
    end
  end
end
