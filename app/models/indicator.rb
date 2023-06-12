class Indicator < ApplicationRecord
  has_one :investment, dependent: :restrict_with_error

  def name_with_rate
    "#{name} - #{rate}"
  end

  def self.ransackable_attributes(_auth_object = nil)
    ['rate']
  end
end
