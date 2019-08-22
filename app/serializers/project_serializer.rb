# frozen_string_literal: true

class ProjectSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :description, :hours_spent, :amount

  belongs_to :client
  has_many :payments
  belongs_to :manager
  has_many :attachments
  has_many :comments
  belongs_to :creater
  has_many :timelogs
end
