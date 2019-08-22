# frozen_string_literal: true

class ClientSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :email

  has_many :projects

  attribute :name_with_email do |object|
    "#{object.name} (#{object.email})"
  end
end
