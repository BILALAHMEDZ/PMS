# frozen_string_literal: true

class ClientSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :email
end
