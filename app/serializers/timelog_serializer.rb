# frozen_string_literal: true

class TimelogSerializer
  include FastJsonapi::ObjectSerializer

  attributes :hours

  belongs_to :employee
  belongs_to :project
  has_many :comments
end
