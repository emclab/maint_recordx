class CreateMaintRecordxMaintReports < ActiveRecord::Migration
  def change
    create_table :maint_recordx_maint_reports do |t|
      t.integer :maint_request_id
      t.datetime :start_datetime
      t.datetime :finish_datetime
      t.text :problem
      t.text :did
      t.string :customer_contact
      t.integer :reported_by_id
      t.integer :last_updated_by_id
      t.boolean :machine_down, :default => true
      t.text :review

      t.timestamps
    end
    
    add_index :maint_recordx_maint_reports, :maint_request_id
    add_index :maint_recordx_maint_reports, :reported_by_id
  end
end
