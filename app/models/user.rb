# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  paginates_per 5

  mount_uploader :image, ImageUploader

  has_many :projects
  has_many :payments
  has_many :comments, foreign_key: 'creater_id'

  scope :all_except, ->(user) { where.not(id: user) }

  TYPE_ADMIN = 'Admin'
  TYPE_MANAGER = 'Manager'
  TYPE_EMPLOYEE = 'Employee'
  TYPES = [TYPE_ADMIN, TYPE_MANAGER, TYPE_EMPLOYEE].freeze

  STATUS_ENABLED = 'Enabled'
  STATUS_DISABLED = 'Disabled'
  STATUSES = [STATUS_ENABLED, STATUS_DISABLED].freeze

  after_initialize :init_default

  def admin?
    type == TYPE_ADMIN
  end

  def employee?
    type == TYPE_EMPLOYEE
  end

  def manager?
    type == TYPE_MANAGER
  end

  def active_for_authentication?
    super && status == STATUS_ENABLED
  end

  def self.search(search_attributes = {})
    term = search_attributes[:search]

    users = self
    users = where('name LIKE (?) OR email LIKE (?)', "%#{term}%", "%#{term}%") if term.present?
    users = users.where(type: search_attributes[:type]) if search_attributes[:type].present?
    users = users.where(status: search_attributes[:status]) if search_attributes[:status].present?

    users.order(:id)
  end

  private

  def init_default
    self.status = STATUS_ENABLED if new_record?
    self.type = TYPE_EMPLOYEE if new_record?
  end
end
