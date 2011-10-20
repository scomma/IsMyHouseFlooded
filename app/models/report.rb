class Report < ActiveRecord::Base
  belongs_to :zone
  validates :zone_id, presence: true

  before_create do
    self.create_zone! do |zone|
      zone.id = zone_id
    end if zone_id.present? and zone.blank?
  end

  after_create do
    Zone.transaction do
      zone.positive_count += 1 if flooded == true
      zone.negative_count += 1 if flooded == false
      zone.reports_count  += 1
      zone.save
    end
  end
end
