require "maint_recordx/engine"

module MaintRecordx
  mattr_accessor :equipment_class
  
  def self.equipment_class
    @@equipment_class.constantize
  end
end
