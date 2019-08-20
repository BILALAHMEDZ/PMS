# frozen_string_literal: true

class Manager::TimelogsController < TimelogsBaseController
  before_action :validate_manager

  def validate_manager
    return if current_user.manager?

    redirect_to :root, alert: 'You are not allowed to access Employee'
  end
end
