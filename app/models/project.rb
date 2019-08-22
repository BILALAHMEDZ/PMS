# frozen_string_literal: true

class Project < ApplicationRecord
  paginates_per 5

  belongs_to :client
  has_many :payments, dependent: :destroy
  belongs_to :manager, class_name: 'User'
  has_many :attachments, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :creater, class_name: 'User'
  has_many :timelogs, dependent: :destroy
  has_and_belongs_to_many :employees, join_table: 'employees_projects'

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  def self.search(search, current_user)
    projects =
      if current_user.admin?
        Project.includes(:payments, :comments, :timelogs, :attachments)
      elsif current_user.manager?
        Project.includes(:payments, :comments, :timelogs, :attachments).where('manager_id = ? OR creater_id = ?', current_user.id, current_user.id)
      elsif current_user.employee?
        current_user.projects.includes(:comments, :timelogs, :attachments)
      end

    projects = projects.where('title LIKE (?)', "%#{search}%") if search
    projects.order(:amount)
  end

  def self.top_projects
    @projects = Project.all.order('amount desc').limit(5)
  end

  def self.bottom_projects
    @projects = Project.all.order('amount asc').limit(5)
  end
end
