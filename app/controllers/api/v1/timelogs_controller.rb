# frozen_string_literal: true

class Api::V1::TimelogsController < ApiController
  before_action :set_timelog, only: %i[show]
  before_action :set_project, only: %i[index]

  def index
    return render json: { message: 'You are not authorize to perform this action' } if (current_user.manager? && current_user.id != @project.manager_id && current_user.id != @project.creater_id) || (current_user.employee? && !@project.employees.include?(current_user))

    @timelogs = @project.timelogs
    json_string = TimelogSerializer.new(@timelogs).serialized_json
    render json: json_string
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded timelog', data: @timelog }, status: :ok
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
    return render json: { message: 'project not found' }, status: :not_found if @project.blank?
  end

  def set_timelog
    @timelog = Timelog.find_by(id: params[:id])
    return render json: { message: 'Timelog not found' }, status: :not_found if @timelog.blank?
  end
end
