# frozen_string_literal: true

class Payment < ApplicationRecord
  paginates_per 5
  validates :payment, presence: true
  belongs_to :project
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :creater, class_name: 'User'
end
