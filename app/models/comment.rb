# frozen_string_literal: true

class Comment < ApplicationRecord
  paginates_per 5
  belongs_to :commentable, polymorphic: true
  belongs_to :creater, class_name: 'User'
end
