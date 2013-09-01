require 'spec_helper'

module MaintRecordx
  describe MaintRequest do
    it "should be OK" do
      c = FactoryGirl.build(:maint_recordx_maint_request)
      c.should be_valid
    end
    
    it "should reject nil equipment_id" do
      c = FactoryGirl.build(:maint_recordx_maint_request, :equipment_id => nil)
      c.should_not be_valid
    end
    
    it "should reject nil maint_instruction" do
      c = FactoryGirl.build(:maint_recordx_maint_request, :maint_instruction => nil)
      c.should_not be_valid
    end
    
    it "should reject nil execution_date" do
      c = FactoryGirl.build(:maint_recordx_maint_request, :execution_date => nil)
      c.should_not be_valid
    end
  end
end
