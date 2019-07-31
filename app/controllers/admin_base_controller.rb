# frozen_string_literal: true

class AdminBaseController < ApplicationController
  before_action :validate_admin

  def validate_admin
    return if current_user.admin?

    redirect_to :root, alert: 'You are not allowed to access admin'
  end
end
