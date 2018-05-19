# frozen_string_literal: true

# Base class for all admin controllers to have the security checks separeted.
class AdminController < ApplicationController
  before_action :current_user_is_admin

  # TODO: checks not working properly, the

  private

  def current_user_is_admin
    :authenticate_user! && current_user.admin!
  end
end
