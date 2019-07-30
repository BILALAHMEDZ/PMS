# frozen_string_literal: true

class Client < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true
  paginates_per 5
end
