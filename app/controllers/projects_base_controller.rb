# frozen_string_literal: true

class ProjectsBaseController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to my_project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit
    find_project
  end

  def update
    find_project
    if @project.update(project_params)
      redirect_to my_project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    find_project
    @project.destroy
    redirect_to my_project, notice: 'Project was successfully destroyed.'
  end

  private

  def find_project
    @project = Project.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @project
  end

  def project_params
    params.require(:project).permit(:title, :description, :hours_spent, :amount)
  end
end
