# frozen_string_literal: true

class ProjectsBaseController < ApplicationController
  before_action :set_timelogs, only: [:show]
  before_action :set_payments, only: [:show]
  before_action :set_comments, only: [:show]
  before_action :set_project, only: %i[show edit update destroy set_payments set_comments]

  def index
    @projects = Project.search(params[:search], current_user).page(params[:page])
  end

  def new
    @project = Project.new
  end

  def show
    @attachments = @project.attachments
    @comment = Comment.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to set_path, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def assigned_employees
    set_project
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to set_path, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to set_path, notice: 'Project was successfully destroyed.'
  end

  private

  def set_payments
    @payments = @project.payments.order(:created_at)
  end

  def set_timelogs
    # change
    @project = Project.find_by(id: params[:id])
    return redirect_to root_path, alert: 'Project not found' if @project.blank?

    @timelogs = @project.timelogs.order(:created_at)
  end

  def set_comments
    @comments = @project.comments.order(:id).reverse_order
  end

  def set_project
    @project = Project.find_by(id: params[:id])
    return redirect_to root_path, alert: 'Project not found' if @project.blank?
  end

  def project_params
    params.require(:project).permit(:title, :description, :client_id, :creater_id, :hours_spent, :amount, :manager_id, employee_ids: [])
  end
end
