class ApplicationController < ActionController::Base
    include SessionsHelper
    before_action :login_required
  
    private
  
    def login_required
      redirect_to new_session_path unless current_user
    end

    def admin_required
      unless current_user&.admin?
        flash[:alert] = t('notice.admin_cannot_access')
        redirect_to root_path
      end
    end
  end