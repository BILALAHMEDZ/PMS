# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  scope :all_except, ->(user) { where.not(id: user) }
  TYPE_ADMIN = 'Admin'
  TYPE_MANAGER = 'Manager'
  TYPES = [TYPE_ADMIN, TYPE_MANAGER].freeze
  STATUS_ENABLED = 'Enabled'
  STATUS_DISABLED = 'Disabled'
  after_initialize :init_default

  private

  def init_default
    if new_record?
      self.status = STATUS_ENABLED
      self.type = 'User'
    end
  end
end
