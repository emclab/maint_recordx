# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :maint_recordx_replaced_part, :class => 'MaintRecordx::ReplacedPart' do
    maint_report_id 1
    name "MyString"
    spec "MyString"
    qty 1
    unit "MyString"
    brief_note "MyText"
  end
end
