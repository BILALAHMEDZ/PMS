# frozen_string_literal: true

class ProjectsBaseController < ApplicationController
  before_action :set_timelogs, only: [:show]
  before_action :set_payments, only: [:show]
  before_action :set_comments, only: [:show]
  def index
    @projects = Project.search(params[:search]).order(:created_at).page(params[:page])
  end

  def new
    @project = Project.new
  end

  def show
        @attachments = @project.attachments
    @project = Project.find_by_id(params[:id])
    @comment = Comment.new
  end

  def create
    @project = Project.new(project_params.except(:employees))
    @empls = project_params[:employees]
    @empls.shift
    @empls.each do |a|
      e = Employee.find(a)
      @project.employees << e
    end
    @project.creater_id = current_user.id
    if @project.save
      redirect_to my_project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def assigned_employees
    set_project
  end

  def edit
    set_project
  end

  def update
    set_project
    @empls = project_params[:employees]
    @abc = project_params.except(:employees)
    @empls.shift
    @project.employees.delete(@project.employees)
    @empls.each do |a|
      e = Employee.find(a)
      @project.employees << e
    end
    @abc[:employees] = @project.employees
    puts @abc
    if @project.update(@abc)
      redirect_to my_project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    set_project
    @project.destroy
    redirect_to my_project, notice: 'Project was successfully destroyed.'
  end

  private

  def set_payments
    set_project
    @payments = @project.payments.order(:created_at).page(params[:page])
  end

  def set_timelogs
    set_project
    @timelogs = @project.timelogs.order(:created_at).page(params[:page])
  end

  def set_comments
    @project = Project.find_by_id(params[:id])
    @comments = @project.comments.order(:id).page(params[:page])
  end

  def set_project
    @project = Project.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @project
  end

  def project_params
    params.require(:project).permit(:title, :description, :hours_spent, :amount, :client_id, :manager_id, employees: [])
  end
end
