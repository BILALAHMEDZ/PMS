# frozen_string_literal: true

class Api::V1::ProjectsController < ApiController
  before_action :authorize_user, only: %i[update destroy create]
  before_action :set_project, only: %i[show destroy update]

  def index
    @projects = Project.search(params[:search], current_user)
    json_string = ProjectSerializer.new(@projects).serialized_json
    render json: json_string
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded Project', data: @project }, status: :ok
  end

  def create
    project = Project.new(project_params)

    if project.save
      render json: { status: 'SUCCESS', message: 'Saved project', data: project }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Project not saved', data: project.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    render json: { status: 'SUCCESS', message: 'Deleted project', data: @project }, status: :ok
  end

  def update
    if project.update(project_params)
      render json: { status: 'SUCCESS', message: 'Updated project', data: project }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Project not updated', data: project.errors }, status: :unprocessable_entity
    end
  end

  private

  def authorize_user
    render json: { message: 'You are not authorize to perform this action' } if current_user.employee?
  end

  def set_project
    @project = Project.find_by(id: params[:id])
    return render json: { message: 'project not found' }, status: :not_found if @project.blank?
  end

  def project_params
    params.require(:project).permit(:title, :description, :client_id, :creater_id, :hours_spent, :amount, :manager_id, { employee_ids: [] })
  end
end
