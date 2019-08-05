# frozen_string_literal: true

class TimelogsBaseController < ApplicationController
  def index
    @project = Project.find_by_id(params[:project_id])
    render file: 'public/404.html', status: :not_found, layout: false unless @project
    @timelogs = @project.timelogs
  end

  def new
    @timelog = Timelog.new
  end

  def show
    find_timelog
  end

  def create
    if current_user.admin?
      @timelog = Timelog.new(timelog_params)
      @timelog.project_id = params[:project_id]
      if @timelog.save
        redirect_to my_timelog, notice: 'Timelog was successfully created.'
      else
        render :new
      end
    elsif current_user.employee?
      @timelog = Timelog.new(employee_timelog_params)
      @timelog.project_id = params[:project_id]
      @timelog.employee_id = current_user.id
      if @timelog.save
        redirect_to my_timelog, notice: 'Timelog was successfully created.'
      else
        render :new
      end
    end
  end

  def edit
    find_timelog
  end

  def update
    find_timelog
    if @timelog.update(timelog_params)
      redirect_to my_timelog, notice: 'Timelog was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    find_timelog
    @timelog.destroy
    redirect_to my_timelog, notice: 'Timelog was successfully destroyed.'
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
