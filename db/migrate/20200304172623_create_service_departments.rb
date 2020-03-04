class CreateServiceDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :service_departments do |t|
      t.belongs_to :service
	  	t.belongs_to :department

      t.timestamps
    end
  end
end
