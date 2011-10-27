class FloodLevel < ActiveRecord::Base
  belongs_to :zone
  validates :zone, presence: true
  has_many :reports, through: :zone

  validates :at, presence: true

  def relevant_reports
    from = at - Report::WINDOW.hours
    to   = at
    reports.where{{created_at.gt => from, created_at.lt => to}}
  end

  def update_level
    counts      = relevant_reports.group{flooded}.count
    true_count  = counts[true].to_i
    total_count = true_count + counts[false].to_i
    self.level  = (100.0 * true_count / total_count).round if total_count > 2
  end

  after_validation :update_level, on: :create

  def self.create_all_at at
    Zone.all.each do |zone|
      find_or_create_by_zone_id_and_at zone.id, at
    end
  end

  def self.create_all_between from, to
    at = from.beginning_of_hour
    while at < to
      create_all_at at
      at += 1.hour
    end
  end
end
