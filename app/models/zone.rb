# encoding: UTF-8
class Zone < ActiveRecord::Base
  validates :id, length:{ is: 5, message: "โปรดกรอกรหัสไปรษณีย์ที่ถูกต้อง" },
                 numericality:{ greater_than: 10000, message: "โปรดกรอกรหัสไปรษณีย์ที่ถูกต้อง" }

  has_many :reports

  def positive_percent
    100.0 * positive_count / reports_count
  end

  def negative_percent
    100.0 * negative_count / reports_count
  end
end
