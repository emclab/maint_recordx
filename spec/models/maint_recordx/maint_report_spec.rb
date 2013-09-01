require 'spec_helper'

module MaintRecordx
  describe MaintReport do
    it "should be OK" do
      c = FactoryGirl.build(:maint_recordx_maint_report)
      c.should be_valid
    end
    
    it "should reject nil maint_request_id" do
      c = FactoryGirl.build(:maint_recordx_maint_report, :maint_request_id => nil)
      c.should_not be_valid
    end
    
    it "should reject nil problem" do
      c = FactoryGirl.build(:maint_recordx_maint_report, :problem => nil)
      c.should_not be_valid
    end
    
    it "should reject nil did" do
      c = FactoryGirl.build(:maint_recordx_maint_report, :did => nil)
      c.should_not be_valid
    end
    
    it "should reject nil start_datetime" do
      c = FactoryGirl.build(:maint_recordx_maint_report, :start_datetime => nil)
      c.should_not be_valid
    end
    
    it "should reject nil finish_datetime" do
      c = FactoryGirl.build(:maint_recordx_maint_report, :finish_datetime => nil)
      c.should_not be_valid
    end
  end
end
