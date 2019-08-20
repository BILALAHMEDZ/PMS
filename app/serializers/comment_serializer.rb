# frozen_string_literal: true

class CommentSerializer
  include FastJsonapi::ObjectSerializer

  attributes :message, :commentable_type
end
