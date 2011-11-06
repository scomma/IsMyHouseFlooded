# encoding: UTF-8
class Zone < ActiveRecord::Base
  extend ActiveSupport::Memoizable
  validates :id, length:{ is: 5, message: "โปรดกรอกรหัสไปรษณีย์ที่ถูกต้อง" },
                 numericality:{ greater_than: 10000, message: "โปรดกรอกรหัสไปรษณีย์ที่ถูกต้อง" }

  has_many :reports, order: 'created_at DESC'

  def recent_reports
    recent = reports.recent
    recent = reports.limit(30) if recent.size < 30
    recent
  end

  memoize :recent_reports

  def positive_percent
    reports_count > 0 ? 100.0 * positive_count / reports_count : 0
  end

  def negative_percent
    100.0 * negative_count / reports_count
  end

  def classification
    [positive_percent > 20 ? 'flooded' : 'dry',
     reports_count > 3 ? 'significant' : 'insignificant'
    ].join ' '
  end

  def metadata
    { symbol: id, time: updated_at.utc.to_s, count: reports_count, flood: positive_percent.round }
  end

  def to_s
    id
  end

  has_many :flood_levels

  def historical_levels
    flood_levels.order{at.desc}.limit(72).all.reverse
  end

  def current_level
    flood_levels.find_by_at DateTime.now.beginning_of_hour
  end

  memoize :historical_levels, :current_level

  def update_statistics!
    counts = reports.recent.except(:order).group{flooded}.count
    self.positive_count = counts[true]  || 0
    self.negative_count = counts[false] || 0
    self.reports_count  = positive_count + negative_count
    save!
  end
end
