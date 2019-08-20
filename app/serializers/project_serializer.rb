# frozen_string_literal: true

class ProjectSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :description
end
