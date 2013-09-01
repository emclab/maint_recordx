require_dependency "maint_recordx/application_controller"

module MaintRecordx
  class MaintReportsController < ApplicationController
    before_filter :require_employee
    before_filter :load_maint_request
    
    def index
      @title = t('Maintanence Reports')
      if @maint_request
        @maint_reports = @maint_request.maint_reports.order('created_at DESC')
      else
        @maint_reports = params[:maint_recordx_maint_reports][:model_ar_r].page(params[:page]).per_page(@max_pagination)
      end
      @erb_code = find_config_const('maint_report_index_view', 'maint_recordx_maint_reports')
    end
  
    def new
      @title = t('New Maintanence Report')
      @maint_report = MaintRecordx::MaintReport.new()
      @erb_code = find_config_const('maint_report_new_view', 'maint_recordx_maint_reports')
    end
  
    def create
      @maint_report = MaintRecordx::MaintReport.new(params[:maint_report], :as => :role_new)
      @maint_report.last_updated_by_id = session[:user_id]
      @maint_report.reported_by_id = session[:user_id]
      if @maint_report.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Maintanence Report')
      @maint_report = MaintRecordx::MaintReport.find_by_id(params[:id])
      @erb_code = find_config_const('maint_report_edit_view', 'maint_recordx_maint_reports')
    end
  
    def update
      @maint_report = MaintRecordx::MaintReport.find_by_id(params[:id])
      @maint_report.last_updated_by_id = session[:user_id]
      if @maint_report.update_attributes(params[:maint_report], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('Show Maintanence Report')
      @maint_report = MaintRecordx::MaintReport.find_by_id(params[:id])
      @erb_code = find_config_const('maint_report_show_view', 'maint_recordx_maint_reports')
    end
    
    protected
    
    def load_maint_request
      @maint_request = MaintRecordx.MaintRequest.find_by_id(params[:maint_request_id]) if params[:maint_request_id].present?
    end
  end
end
