module MaintRecordx
  class ReplacedPart < ActiveRecord::Base
    attr_accessible :brief_note, :maint_report_id, :name, :qty, :spec, :unit, :as => :role_new
    attr_accessible :brief_note, :maint_report_id, :name, :qty, :spec, :unit, :as => :role_update
    
    belongs_to :maint_report, :class_name => 'MaintRecordx::MaintReport'
    
    validates_presence_of :name, :qty, :unit, :spec
  end
end
