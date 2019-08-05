# frozen_string_literal: true

class Timelog < ApplicationRecord
  belongs_to :employee, class_name: 'User'
  belongs_to :project
end
