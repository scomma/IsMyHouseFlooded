class Zone < ActiveRecord::Base
  has_many :reports

  default_scope order{reports_count.desc}

  def positive_percent
    100.0 * positive_count / reports_count
  end

  def negative_percent
    100.0 * negative_count / reports_count
  end
end
