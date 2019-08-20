# frozen_string_literal: true

class TimelogSerializer
  include FastJsonapi::ObjectSerializer
  attributes :hours
end
