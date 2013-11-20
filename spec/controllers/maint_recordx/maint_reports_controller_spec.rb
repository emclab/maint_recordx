require 'spec_helper'

module MaintRecordx
  describe MaintReportsController do
    before(:each) do
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      config = FactoryGirl.create(:engine_config, :engine_name => 'maint_recordx', :engine_version => nil, :argument_name => 'qty_unit', :argument_value => 'piece, set, meter')
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
      it "returns all reports" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'maint_recordx_maint_reports', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "MaintRecordx::MaintReport.order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        equip1 = FactoryGirl.create(:machine_toolx_machine_tool, :name => 'new_name', :serial_num => 'new serial')
        request = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id)
        request1 = FactoryGirl.create(:maint_recordx_maint_request, :maint_instruction => 'new serial', :equipment_id => equip1.id)
        sup = FactoryGirl.create(:maint_recordx_maint_report, :maint_request_id => request.id)
        sup1 = FactoryGirl.create(:maint_recordx_maint_report, :problem => 'new stuff', :maint_request_id => request1.id)
        get 'index', {:use_route => :maint_recordx}
        assigns(:maint_reports).should =~ [sup, sup1]
      end
      
      it "should return reports for the request" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'maint_recordx_maint_reports', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "MaintRecordx::MaintReport.order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        equip1 = FactoryGirl.create(:machine_toolx_machine_tool, :name => 'new_name', :serial_num => 'new serial')
        request = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id)
        request1 = FactoryGirl.create(:maint_recordx_maint_request, :maint_instruction => 'new serial', :equipment_id => equip1.id)
        sup = FactoryGirl.create(:maint_recordx_maint_report, :maint_request_id => request.id)
        sup1 = FactoryGirl.create(:maint_recordx_maint_report, :maint_request_id => request1.id)
        get 'index', {:use_route => :maint_recordx, :maint_request_id => request.id}
        assigns(:maint_reports).should =~ [sup]
      end
    end
  
    describe "GET 'new'" do
      it "should display the new page" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'maint_recordx_maint_reports', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        request = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id)
        get 'new', {:use_route => :maint_recordx, :maint_request_id => request.id}
        response.should be_success
      end
    end
  
    describe "GET 'create'" do
      it "should create a new record" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'maint_recordx_maint_reports', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        request = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id)
        sup = FactoryGirl.attributes_for(:maint_recordx_maint_report, :maint_request_id => request.id)
        get 'create', {:use_route => :maint_recordx, :maint_report => sup, :maint_request_id => request.id}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render new with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'maint_recordx_maint_reports', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        request = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id)
        sup = FactoryGirl.attributes_for(:maint_recordx_maint_report, :maint_request_id => request.id, :maint_instruction => nil)
        get 'create', {:use_route => :maint_recordx, :maint_port => sup, :maint_request_id => request.id}
        response.should render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns render edit page" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'maint_recordx_maint_reports', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        request = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id, :maint_type_id => @maint_type.id)
        sup = FactoryGirl.create(:maint_recordx_maint_report, :maint_request_id => request.id, :last_updated_by_id => @u.id)       
        get 'edit', {:use_route => :maint_recordx, :id => sup.id, :maint_request_id => request.id}
        response.should be_success
      end
    end
  
    describe "GET 'update'" do
      it "returns updated page" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'maint_recordx_maint_reports', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        request = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id, :maint_type_id => @maint_type.id)
        sup = FactoryGirl.create(:maint_recordx_maint_report, :maint_request_id => request.id)
        get 'update', {:use_route => :maint_recordx, :id => sup.id, :maint_request_id => request.id, :maint_report => {:did => 'a new name'}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'maint_recordx_maint_reports', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        request = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id, :maint_type_id => @maint_type.id)
        sup = FactoryGirl.create(:maint_recordx_maint_report, :maint_request_id => request.id)
        get 'update', {:use_route => :maint_recordx, :id => sup.id, :maint_request_id => request.id, :maint_report => {:did => ''}}
        response.should render_template('edit')
      end
    end
  
    describe "GET 'show'" do
      it "should show" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'maint_recordx_maint_reports', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        request = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id, :maint_type_id => @maint_type.id)
        sup = FactoryGirl.create(:maint_recordx_maint_report, :maint_request_id => request.id, :last_updated_by_id => session[:user_id])
        get 'show', {:use_route => :maint_recordx, :id => sup.id, :maint_request_id => request.id}
        response.should be_success
      end
    end
  
  end
end
