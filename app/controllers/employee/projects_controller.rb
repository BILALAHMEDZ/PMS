# frozen_string_literal: true

class Employee::ProjectsController < ApplicationController
  def index
    @projects = current_user.projects
  end
end
