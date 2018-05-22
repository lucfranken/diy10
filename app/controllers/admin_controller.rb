# frozen_string_literal: true

# Base class for all admin controllers to have the security checks separeted.
class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user_is_admin

  # TODO: checks not working properly, the

  private

  def current_user_is_admin
    if !current_user.admin?
      raise "Not authenticated"
    end
  end
end
