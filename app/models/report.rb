# encoding: UTF-8
class Report < ActiveRecord::Base
  belongs_to :zone
  validates :zone_id, presence: true

  validates_each :ip_address, on: :create do |record, attr, value|
    record.errors.add attr, "ไม่สามารถรายงานถี่เกินไป" if
      Report.where{(zone_id == record.zone_id) & (created_at > 1.minute.ago)}.exists?
  end

  before_create do
    self.create_zone! do |zone|
      zone.id = zone_id
    end if zone_id.present? and zone.blank?
  end

  after_create do
    Zone.transaction do
      zone.positive_count += 1 if flooded == true
      zone.negative_count += 1 if flooded == false
      zone.reports_count  += 1 if flooded.in? [true, false]
      zone.save
    end
  end

  scope :recent, ->{ where{created_at > 12.hours.ago} }

  def classification
    if flooded == true
      'flooded'
    elsif flooded == false
      'dry'
    end
  end

  def human_flooded
    if flooded == true
      "ท่วม"
    elsif flooded == false
      "ไม่ท่วม"
    end
  end

  def to_s
    comment
  end

  def blank?
    flooded == nil and comment.blank?
  end

  def as_json(options = {})
    super options.merge(except: [:ip_address, :author, :updated_at])
  end
end
