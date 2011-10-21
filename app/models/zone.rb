class Zone < ActiveRecord::Base
  validates :id, length:{ is: 5 }, numericality:{ greater_than: 10000 } # valid postal code in Thailand

  has_many :reports

  def positive_percent
    100.0 * positive_count / reports_count
  end

  def negative_percent
    100.0 * negative_count / reports_count
  end
end
