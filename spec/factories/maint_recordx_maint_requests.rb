# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :maint_recordx_maint_request, :class => 'MaintRecordx::MaintRequest' do
    equipment_id 1
    maint_type_id 1
    requested_by_id 1
    last_updated_by_id 1
    maint_instruction "MyText"
    execution_date "2013-08-29"
    estimated_execution_hour 1
    assigned_to_id 1
    other_requirement "MyText"
    cancelled false
    completed false
  end
end
