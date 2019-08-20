# frozen_string_literal: true

class Admin::TimelogsController < TimelogsBaseController
  before_action :validate_admin

  def validate_admin
    return if current_user.admin?

    redirect_to :root, alert: 'You are not allowed to access Admin'
  end
end
