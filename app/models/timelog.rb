# frozen_string_literal: true

class Timelog < ApplicationRecord
  paginates_per 5

  belongs_to :employee, class_name: 'User'
  belongs_to :project
  has_many :comments, as: :commentable, dependent: :destroy

  validates :hours, presence: true, length: { in: 1..4 }, numericality: { only_integer: true }
end
