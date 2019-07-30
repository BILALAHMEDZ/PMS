# frozen_string_literal: true

class ManagerBaseController < ApplicationController
  before_action :validate_manager
  def validate_manager
    authorize Client, :check_manager?, policy_class: ClientsPolicy
  end
end
