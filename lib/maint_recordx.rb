require "maint_recordx/engine"

module MaintRecordx
  mattr_accessor :equipment
  
  def self.equipment
    @@equipment.constantize
  end
end
