require 'spec_helper'

module MaintRecordx
  describe MaintRequestsController do
    before(:each) do
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
    end
    
    before(:each) do
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      @maint_type = FactoryGirl.create(:commonx_misc_definition, :for_which => 'equip_maintanence_type')
      
    end
    
    render_views
    
    describe "GET 'index'" do
      it "returns all requests" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'maint_recordx_maint_requests', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "MaintRecordx::MaintRequest.where(:cancelled => false).order('execution_date DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        sup = FactoryGirl.create(:maint_recordx_maint_request)
        sup1 = FactoryGirl.create(:maint_recordx_maint_request, :execution_date => 1.day.ago)
        get 'index', {:use_route => :maint_recordx}
        assigns(:maint_requests).should =~ [sup, sup1]
      end
      
      it "should return requests for the equipment" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'maint_recordx_maint_requests', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "MaintRecordx::MaintRequest.where(:cancelled => false).order('execution_date DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        equip1 = FactoryGirl.create(:machine_toolx_machine_tool, :name => 'new_name', :serial_num => 'new serial')
        sup = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id)
        sup1 = FactoryGirl.create(:maint_recordx_maint_request, :execution_date => 1.day.ago, :equipment_id => equip1.id)
        get 'index', {:use_route => :maint_recordx, :equipment_id => equip.id}
        assigns(:maint_requests).should =~ [sup]
      end
    end
  
    describe "GET 'new'" do
      it "should display the new page" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'maint_recordx_maint_requests', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        get 'new', {:use_route => :maint_recordx, :equipment_id => equip.id}
        response.should be_success
      end
    end
  
    describe "GET 'create'" do
      it "should create a new record" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'maint_recordx_maint_requests', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        sup = FactoryGirl.attributes_for(:maint_recordx_maint_request, :equipment_id => equip.id)
        get 'create', {:use_route => :maint_recordx, :maint_request => sup}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render new with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'maint_recordx_maint_requests', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        sup = FactoryGirl.attributes_for(:maint_recordx_maint_request, :equipment_id => equip.id, :maint_instruction => nil)
        get 'create', {:use_route => :maint_recordx, :maint_request => sup}
        response.should render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns render edit page" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'maint_recordx_maint_requests', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        sup = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id, :last_updated_by_id => @u.id)       
        get 'edit', {:use_route => :maint_recordx, :id => sup.id, :equipment_id => equip.id}
        response.should be_success
      end
    end
  
    describe "GET 'update'" do
      it "returns updated page" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'maint_recordx_maint_requests', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        sup = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id)
        get 'update', {:use_route => :maint_recordx, :id => sup.id, :maint_request => {:maint_instruction => 'a new name'}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'maint_recordx_maint_requests', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        sup = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id)
        get 'update', {:use_route => :maint_recordx, :id => sup.id, :maint_request => {:execution_date => ''}}
        response.should render_template('edit')
      end
    end
  
    describe "GET 'show'" do
      it "should show" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'maint_recordx_maint_requests', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        sup = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id, :last_updated_by_id => session[:user_id], :maint_type_id => @maint_type.id)
        get 'show', {:use_route => :maint_recordx, :id => sup.id, :equipment_id => equip.id}
        response.should be_success
      end
    end
  
  end
end
