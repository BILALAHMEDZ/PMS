# frozen_string_literal: true

class CommentSerializer
  include FastJsonapi::ObjectSerializer

  attributes :message, :commentable_type

  belongs_to :commentable, polymorphic: true
  belongs_to :creater, class_name: 'User'
end
