# frozen_string_literal: true

class Api::V1::TimelogsController < ApiController
  before_action :authorize_request, except: :create

  def index
    @project = Project.find_by(id: params[:project_id])
    @timelogs = @project.timelogs
    json_string = TimelogSerializer.new(@timelogs).serialized_json
    render json: json_string
  end

  def show
    set_timelog
    render json: { status: 'SUCCESS', message: 'Loaded timelog', data: @timelog }, status: :ok
  end

  private

  def set_timelog
    @timelog = Timelog.find_by(id: params[:id])
    return redirect_to root_path, alert: 'Timelog not found' if @timelog.blank?
  end
end
