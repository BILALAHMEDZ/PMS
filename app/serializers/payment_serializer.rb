# frozen_string_literal: true

class PaymentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :payment
end
