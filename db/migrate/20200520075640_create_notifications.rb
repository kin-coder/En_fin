class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :notif_type
      t.string :data
      t.boolean :is_view, default:false

      t.timestamps
    end
  end
end


# irb(main):027:0> a.to_json
# => "{\"g\":\"google\",\"y\":\"yahoo\"}"
# irb(main):028:0> b = a.to_json
# => "{\"g\":\"google\",\"y\":\"yahoo\"}"
# irb(main):029:0> JSON.parse(b)
# => {"g"=>"google", "y"=>"yahoo"}
