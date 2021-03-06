module MaintRecordx
  class MaintRequest < ActiveRecord::Base
    attr_accessor :equipment_name, :equipment_short_name, :requested_by_name, :last_updated_by_name, :maint_type_name
    attr_accessible :assigned_to_id, :cancelled, :completed, :estimated_execution_hour, :execution_date, :last_updated_by_id, :maint_instruction, 
                    :assigned_to_id, :maint_type_id, :other_requirement, :requested_by_id, :equipment_id, 
                    :as => :role_new
    attr_accessible :assigned_to_id, :cancelled, :completed, :estimated_execution_hour, :execution_date, :last_updated_by_id, :maint_instruction, 
                    :assigned_to_id, :maint_type_id, :other_requirement, :requested_by_id, :equipment_id, 
                    :as => :role_update
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :maint_type, :class_name => 'Commonx::MiscDefinition' 
    belongs_to :assigned_to, :class_name => 'Authentify::User'
    belongs_to :requested_by, :class_name => 'Authentify::User' 
    has_one :maint_report, :class_name => 'MaintRecordx::MaintReport'
    belongs_to :equipment, :class_name => MaintRecordx.equipment.to_s 
    
    validates_presence_of :equipment_id, :maint_instruction, :execution_date 
           
  end
end
