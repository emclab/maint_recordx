require 'spec_helper'

module MaintRecordx
  describe ReplacedPart do
    it "should be OK" do
      c = FactoryGirl.build(:maint_recordx_replaced_part)
      c.should be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:maint_recordx_replaced_part, :name => nil)
      c.should_not be_valid
    end
    
    it "should reject nil spec" do
      c = FactoryGirl.build(:maint_recordx_replaced_part, :spec => nil)
      c.should_not be_valid
    end
    
    it "should reject nil qty" do
      c = FactoryGirl.build(:maint_recordx_replaced_part, :qty => nil)
      c.should_not be_valid
    end
    
    it "should reject nil unit" do
      c = FactoryGirl.build(:maint_recordx_replaced_part, :unit => nil)
      c.should_not be_valid
    end
  end
end
