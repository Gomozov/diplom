class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.string :device_code
      t.string :device_status
      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
