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
    [positive_percent > 20 ? 'flooded' : 'dry',
     reports_count > 9 ? 'significant' : 'insignificant'
    ].join ' '
  end

  def metadata
    { symbol: id, time: updated_at.utc.to_s, count: reports_count, flood: positive_percent.round }
  end

  def to_s
    id
  end


  def update_statistics!
    counts = reports.where{created_at > 1.day.ago}.except(:order).group{flooded}.count
    self.positive_count = counts[true]  || 0
    self.negative_count = counts[false] || 0
    self.reports_count  = positive_count + negative_count
    save!
  end
end
