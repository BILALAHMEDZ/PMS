# frozen_string_literal: true

class Project < ApplicationRecord
  paginates_per 5

  belongs_to :client
  has_many :payments, dependent: :destroy
  belongs_to :manager
  has_many :attachments, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :creater, class_name: 'User'
  has_many :timelogs, dependent: :destroy
  has_and_belongs_to_many :employees, join_table: 'employees_projects'

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  def self.search(search, current_user)
    return @projects = current_user.projects.includes(:comments, :timelogs, :attachments) if current_user.employee?
    return @projects = Project.includes(:payments, :comments, :timelogs, :attachments) if current_user.admin?
    return @projects = Project.includes(:payments, :comments, :timelogs, :attachments).where('manager_id = ? OR creater_id = ?', current_user.id, current_user.id) if current_user.manager?

    if search
      where('title LIKE (?)', "%#{search}%")
    else
      all
    end.order(:amount)
  end

  def self.top_projects
    @projects = Project.all.order('amount desc').limit(5)
  end

  def self.bottom_projects
    @projects = Project.all.order('amount asc').limit(5)
  end
end
