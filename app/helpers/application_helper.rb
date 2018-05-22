module ApplicationHelper

  def current_controller(controller)

    return 'active' if controller_name == controller
    ''
  end

end