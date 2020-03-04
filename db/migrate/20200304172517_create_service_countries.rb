class CreateServiceCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :service_countries do |t|
      t.belongs_to :service
	  t.belongs_to :country

      t.timestamps
    end
  end
end
