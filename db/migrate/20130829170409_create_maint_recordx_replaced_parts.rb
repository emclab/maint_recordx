class CreateMaintRecordxReplacedParts < ActiveRecord::Migration
  def change
    create_table :maint_recordx_replaced_parts do |t|
      t.integer :maint_report_id
      t.string :name
      t.string :spec
      t.integer :qty
      t.string :unit
      t.text :brief_note

      t.timestamps
    end
    
    add_index :maint_recordx_replaced_parts, :maint_report_id
  end
end
