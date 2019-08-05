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
    type == 'Admin'
  end

  def employee?
    type == 'Employee'
  end

  def manager?
    type == 'Manager'
  end

  def active_for_authentication?
    super && status == 'Enabled'
  end

  def self.search(search)
    if search
      where('name LIKE (?) OR email LIKE (?) OR type LIKE (?) OR status LIKE (?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  private

  def init_default
    if new_record?
      self.status = STATUS_ENABLED
      self.type = TYPE_EMPLOYEE
    end
  end
end
