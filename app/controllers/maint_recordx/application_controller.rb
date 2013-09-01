module MaintRecordx
  class ApplicationController < ApplicationController
    include Authentify::SessionsHelper
    include Authentify::AuthentifyUtility
    include Authentify::UsersHelper
    include Authentify::UserPrivilegeHelper
    include Commonx::CommonxHelper
    
    before_filter :require_signin
    before_filter :check_access_right 
    before_filter :max_pagination 
  end
end
