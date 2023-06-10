class Indicator < ApplicationRecord
  def name_with_rate
    "#{name} - #{rate}"
  end

  def self.ransackable_attributes(_auth_object = nil)
    ['rate']
  end
end
