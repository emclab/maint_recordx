class CreateMaintRecordxMaintRequests < ActiveRecord::Migration
  def change
    create_table :maint_recordx_maint_requests do |t|
      t.integer :equipment_id
      t.integer :maint_type_id
      t.integer :requested_by_id
      t.integer :last_updated_by_id
      t.text :maint_instruction
      t.date :execution_date
      t.integer :estimated_execution_hour
      t.integer :assigned_to_id
      t.text :other_requirement
      t.boolean :cancelled, :default => false
      t.boolean :completed, :default => false

      t.timestamps
    end
    
    add_index :maint_recordx_maint_requests, :equipment_id 
    add_index :maint_recordx_maint_requests, :assigned_to_id
    add_index :maint_recordx_maint_requests, :maint_type_id
  end
end
