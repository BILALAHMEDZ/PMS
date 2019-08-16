# frozen_string_literal: true

class ProjectsBaseController < ApplicationController
  before_action :set_timelogs, only: [:show]
  before_action :set_payments, only: [:show]
  before_action :set_comments, only: [:show]
  before_action :set_project, only: %i[show edit update destroy set_payments set_comments]

  def index
    # change
    return @projects = Project.search(params[:search]).page(params[:page]) if current_user.admin?
    return @projects = Project.where('manager_id = ? OR creater_id = ?', current_user.id, current_user.id).search(params[:search]).page(params[:page]) if current_user.manager?
    return @projects = current_user.projects.search(params[:search]).page(params[:page]) if current_user.employee?
  end

  def new
    @project = Project.new
  end

  def show
    @attachments = @project.attachments
    @comment = Comment.new
  end

  def create
    # change
    @project = Project.new(project_params.except(:employees))
    @empls = project_params[:employees]
    @empls.shift
    @empls.each do |a|
      e = Employee.find(a)
      @project.employees << e
    end
    if @project.save
      redirect_to my_project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def assigned_employees
    set_project
  end

  def edit; end

  def update
    # change
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
    @project.destroy
    redirect_to my_project, notice: 'Project was successfully destroyed.'
  end

  private

  def set_payments
    @payments = @project.payments.order(:created_at)
  end

  def set_timelogs
    set_project
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
    params.require(:project).permit(:title, :description, :client_id, :creater_id, :hours_spent, :amount, :manager_id, employees: [])
  end
end
