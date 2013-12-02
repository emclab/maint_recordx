module MaintRecordx
  class MaintReport < ActiveRecord::Base
    attr_accessor :equipment_name, :equipment_short_name, :reported_by_name, :last_updated_by_name, :maint_type_name
    attr_accessible :customer_contact, :did, :reported_by_id, :finish_datetime, :last_updated_by_id, :machine_down, :maint_request_id, :problem, :review, 
                    :start_datetime, :replaced_parts_attributes, :as => :role_new
    attr_accessible :customer_contact, :did, :reported_by_id, :finish_datetime, :last_updated_by_id, :machine_down, :maint_request_id, :problem, :review, 
                    :start_datetime, :replaced_parts_attributes, :as => :role_update
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :maint_request, :class_name => 'MaintRecordx::MaintRequest'
    belongs_to :reported_by, :class_name => 'Authentify::User'
    has_many :replaced_parts, :class_name => 'MaintRecordx::ReplacedPart'
    
    accepts_nested_attributes_for :replaced_parts, :allow_destroy => true
    
    validates :did, :problem, :start_datetime, :finish_datetime, :presence => true
    validates :maint_request_id, :presence => true, :numericality => {:greater_than => 0}
  end
end
