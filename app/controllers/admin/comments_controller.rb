# frozen_string_literal: true

class Admin::CommentsController < CommentsBaseController
  before_action :validate_admin
  def validate_admin
    return if current_user.admin?

    redirect_to :root, alert: 'You are not allowed to access Admin'
  end

  def my_comment
    admin_comments_path
  end
end
