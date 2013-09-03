require_dependency "maint_recordx/application_controller"

module MaintRecordx
  class MaintRequestsController < ApplicationController
    #maint = maintanence
    #new_maint_request_path(params[:equipment_id]), edit_maint_request_path(params[:equipment_id])
    before_filter :require_employee
    before_filter :load_equipment
    
    def index
      @title = t('Maintanence Requests')
      if @equipment
        @maint_requests = MaintRequest.where(:cancelled => false).where('equipment_id = ?', @equipment.id).page(params[:page]).per_page(@max_pagination)
      else
        @maint_requests = params[:maint_recordx_maint_requests][:model_ar_r].page(params[:page]).per_page(@max_pagination)
      end
      @erb_code = find_config_const('maint_request_index_view', 'maint_recordx_maint_requests')
    end
  
    def new
      @title = t('New Maintanence Request')
      @maint_request = MaintRecordx::MaintRequest.new()
      @erb_code = find_config_const('maint_request_new_view', 'maint_recordx_maint_requests')
    end
  
    def create
      @maint_request = MaintRecordx::MaintRequest.new(params[:maint_request], :as => :role_new)
      @equipment = MaintRecordx.equipment.find_by_id(params[:maint_request][:equipment_id].to_i)
      @maint_request.last_updated_by_id = session[:user_id]
      @maint_request.requested_by_id = session[:user_id]
      if @maint_request.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Maintanence Request')
      @maint_request = MaintRecordx::MaintRequest.find_by_id(params[:id])
      @erb_code = find_config_const('maint_request_edit_view', 'maint_recordx_maint_requests')
    end
  
    def update
      @maint_request = MaintRecordx::MaintRequest.find_by_id(params[:id])
      @maint_request.last_updated_by_id = session[:user_id]
      @equipment = MaintRecordx.equipment.find_by_id(@maint_request.equipment_id)
      if @maint_request.update_attributes(params[:maint_request], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('Show Maintanence Request')
      @maint_request = MaintRecordx::MaintRequest.find_by_id(params[:id])
      @erb_code = find_config_const('maint_request_show_view', 'maint_recordx_maint_requests')
    end
    
    protected
    
    def load_equipment
      @equipment = MaintRecordx.equipment.find_by_id(params[:equipment_id]) if params[:equipment_id].present?
    end
  end
end
