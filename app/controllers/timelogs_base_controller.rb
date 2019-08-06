# frozen_string_literal: true

class TimelogsBaseController < ApplicationController
  def index
    @project = Project.find_by_id(params[:project_id])
    render file: 'public/404.html', status: :not_found, layout: false unless @project
    @timelogs = @project.timelogs
  end

  def new
    @project = Project.find(params[:project_id])
    @timelog = Timelog.new
  end

  def show
    find_timelog
  end

  def create
    if current_user.admin?
      @project = Project.find(params[:project_id])
      @timelog = @project.timelogs.new(timelog_params)
      respond_to do |format|
        format.js
      end
    elsif current_user.employee?
      @project = Project.find(params[:project_id])
      @timelog = @project.timelogs.new(employee_timelog_params)
      @timelog.employee_id = current_user.id
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    find_timelog
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.js
    end
  end

  def update
    find_timelog
    @timelog.assign_attributes(timelog_params)
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    find_timelog
    @project = @timelog.project
    @timelog.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def find_timelog
    @timelog = Timelog.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @timelog
  end

  def timelog_params
    params.require(:timelog).permit(:hours, :employee_id)
  end

  def employee_timelog_params
    params.require(:timelog).permit(:hours)
  end
end
