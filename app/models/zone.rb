# encoding: UTF-8
class Zone < ActiveRecord::Base
  validates :id, length:{ is: 5, message: "โปรดกรอกรหัสไปรษณีย์ที่ถูกต้อง" },
                 numericality:{ greater_than: 10000, message: "โปรดกรอกรหัสไปรษณีย์ที่ถูกต้อง" }

  has_many :reports, order: 'created_at DESC'

  def positive_percent
    reports_count > 0 ? 100.0 * positive_count / reports_count : 0
  end

  def negative_percent
    100.0 * negative_count / reports_count
  end

  def classification
    positive_percent > 20 ? 'flooded' : 'dry'
  end

  def metadata
    { symbol: id, time: updated_at.utc.to_s, count: reports_count, flood: positive_percent }
  end

  def to_s
    id
  end
end
