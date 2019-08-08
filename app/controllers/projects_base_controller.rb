# frozen_string_literal: true

class ProjectsBaseController < ApplicationController
  before_action :set_timelogs, only: [:show]
  before_action :set_payments, only: [:show]
  before_action :set_comments, only: [:show]
  before_action :set_project, only: [:show, :edit, :update, :destroy, :set_payments, :set_comments]

  def index
    @projects = Project.search(params[:search]).page(params[:page])
  end

  def new
    @project = Project.new
  end

  def show
    @attachments = @project.attachments
    @comment = Comment.new
  end

  def create
    #change
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
  end

  def update
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
    params.require(:project).permit(:title, :description, :hours_spent, :amount, :client_id, :manager_id, employees: [])
  end
end
