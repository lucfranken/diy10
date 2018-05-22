# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_current_user

  before_action :set_locale

  private

  def set_current_user
    Current.user = current_user
  end
   
  def set_locale
    I18n.locale = :nl || I18n.default_locale
  end
end
