class CreateReportFields < ActiveRecord::Migration
  def self.up
    create_table :report_fields do |t|
      t.integer :report_id
      t.string :key
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop table :report_fields
  end
end
