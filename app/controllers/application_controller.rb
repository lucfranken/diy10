# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_current_project

  before_action :set_locale

  private

  def set_current_project
    if current_user
      Current.project = current_user.projects.first
    end
  end
   
  def set_locale
    I18n.locale = :nl || I18n.default_locale
  end

    def after_sign_in_path_for(resource)
      resource.admin? ? admin_dashboards_path : welcome_index_path
    end
end
