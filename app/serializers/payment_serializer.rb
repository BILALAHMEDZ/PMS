# frozen_string_literal: true

class PaymentSerializer
  include FastJsonapi::ObjectSerializer

  attributes :payment

  belongs_to :project
  has_many :comments
  belongs_to :creater
end
