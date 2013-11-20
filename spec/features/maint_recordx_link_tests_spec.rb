require 'spec_helper'

describe "LinkTests" do
  describe "GET /maint_recordx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      config = FactoryGirl.create(:engine_config, :engine_name => 'maint_recordx', :engine_version => nil, :argument_name => 'qty_unit', :argument_value => 'piece, set, meter')
      #qs = FactoryGirl.create(:commonx_misc_definition, :name => 'ISO9000', :for_which => 'quality_system')
      #qs1 = FactoryGirl.create(:commonx_misc_definition, :name => 'QS9000', :for_which => 'quality_system')
      #add = FactoryGirl.create(:address)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur], :login => 'thistest', :password => 'password', :password_confirmation => 'password')
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'maint_recordx_maint_requests', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "MaintRecordx::MaintRequest.where(:cancelled => false)")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'maint_recordx_maint_requests', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'maint_recordx_maint_requests', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'maint_recordx_maint_reports', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "MaintRecordx::MaintReport.scoped")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'maint_recordx_maint_reports', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'maint_recordx_maint_reports', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      @maint_type = FactoryGirl.create(:commonx_misc_definition, :for_which => 'equip_maintanence_type')
      
           
      visit '/'
      ##save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => 'password'
      click_button 'login'
    end
        
    it "works!" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      equip = FactoryGirl.create(:machine_toolx_machine_tool)
      equip1 = FactoryGirl.create(:machine_toolx_machine_tool, :name => 'a new name', :serial_num => '12345')
      req = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip.id)
      report = FactoryGirl.create(:maint_recordx_maint_report, :maint_request_id => req.id)
      visit maint_requests_path()
      click_link('Edit')
      #save_and_open_page
      page.body.should have_content('Maintanence Type')
      visit maint_reports_path()
      #save_and_open_page
      click_link('Edit')
      #save_and_open_page
      #click_link('Add Replaced Part')
      #save_and_open_page
      req1 = FactoryGirl.create(:maint_recordx_maint_request, :equipment_id => equip1.id)
      visit new_maint_request_maint_report_path(req1, :parent_record_id => req1, :parent_resource => 'maint_recordx/maint_requests')  #verified that both parent_record_id and parent_resource passed in correctly
      #save_and_open_page
      page.body.should have_content('List Replaced Parts:')
      #click_link('Add Replaced Part')
      #save_and_open_page
      #page.body.should have_content('Part Name')
    end
  end
end
