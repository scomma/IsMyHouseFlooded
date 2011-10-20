class Report < ActiveRecord::Base
  belongs_to :zone, counter_cache: true
  validates :zone_id, presence: true

  after_create do
    Zone.transaction do
      zone.positive_count += 1 if flooded == true
      zone.negative_count += 1 if flooded == false
      zone.total_count    += 1
      zone.save
    end
  end
end
