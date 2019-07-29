# frozen_string_literal: true

class AdminBaseController < ApplicationController
  before_action :validate_admin
  def validate_admin
    authorize User, :check_admin?
  end
end
