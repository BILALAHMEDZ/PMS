# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name

  has_many :comments
end
