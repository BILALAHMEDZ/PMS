# frozen_string_literal: true

class TimelogsBaseController < ApplicationController
  before_action :set_comments, only: [:show]
  before_action :set_timelog, only: [:show, :edit, :update, :destroy]

  def index
    @project = Project.find_by(id: params[:project_id])
    render file: 'public/404.html', status: :not_found, layout: false unless @project
    @timelogs = @project.timelogs
  end

  def new
    @project = Project.find(params[:project_id])
    @timelog = Timelog.new
  end

  def show
    @comment = Comment.new
  end

  def create
    @project = Project.find(params[:project_id])
    @timelog = @project.timelogs.new(timelog_params)
    respond_to do |format|
      format.js
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @timelog.assign_attributes(timelog_params)
    @project = Project.find(params[:project_id])
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

  def set_comments
    set_timelog
    @comments = @timelog.comments.order(:id).reverse_order
  end

end
