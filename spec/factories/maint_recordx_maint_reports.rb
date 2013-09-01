# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :maint_recordx_maint_report, :class => 'MaintRecordx::MaintReport' do
    maint_request_id 1
    start_datetime "2013-08-29 10:47:28"
    finish_datetime "2013-08-29 10:47:28"
    problem "problem desp"
    did "what you did"
    customer_contact "MyString"
    reported_by_id 1
    last_updated_by_id 1
    machine_down true
    review "good bad"
  end
end
