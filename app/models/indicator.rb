class Indicator < ApplicationRecord
  def name_with_rate
    "#{name} - #{rate}"
  end
end
