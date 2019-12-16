class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string :code
      t.string :namedepartment
      t.belongs_to :country, index:true
      
      t.timestamps
    end
  end
end
