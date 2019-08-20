# frozen_string_literal: true

class TimelogsBaseController < ApplicationController
  before_action :set_comments, only: [:show]
  before_action :set_timelog, only: %i[show edit update destroy]
  before_action :set_project, only: %i[index new edit update create]

  def index
    @timelogs = @project.timelogs.includes(:comments).order(:id)
  end

  def new
    @timelog = Timelog.new
  end

  def show
    @comment = Comment.new
  end

  def create
    @timelog = @project.timelogs.new(timelog_params)
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @timelog.assign_attributes(timelog_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @project = @timelog.project
    @timelog.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_timelog
    @timelog = Timelog.find_by(id: params[:id])
    return redirect_to root_path, alert: 'Timelog not found' if @timelog.blank?
  end

  def timelog_params
    params.require(:timelog).permit(:hours, :employee_id)
  end

  def set_project
    @project = Project.find_by(id: params[:project_id])
    return redirect_to root_path, alert: 'Project not found' if @project.blank?
  end

  def set_comments
    set_timelog
    @comments = @timelog.comments.order(:id).reverse_order
  end
end
