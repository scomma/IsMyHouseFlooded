# encoding: UTF-8
class Report < ActiveRecord::Base
  WINDOW = 18

  belongs_to :zone
  #validates :zone_id, presence: true
  validates :zone, presence: true

  validates_each :ip_address, on: :create do |record, attr, value|
    record.errors.add attr, "ไม่สามารถรายงานถี่เกินไป" if
      #Report.where{(zone_id == record.zone_id) & (created_at > 1.minute.ago)}.exists?
      Report.where{(zone == record.zone) & (created_at > 1.minute.ago)}.exists?      
  end

  before_create do
    # zone_id is the primarykey managed by active_record. this is wrong style. you shoulnd set an ID manually
    # how can you assign to a zone which doenst exist? if you wanna do this, better do
    # self.zone = Zone.create
    # just in that way.    
    self.create_zone! do |zone|
      zone.id = zone_id
    end if zone_id.present? and zone.blank?
  end

  after_create do
    Zone.transaction do
      if flooded      
        zone.positive_count += 1
        zone.negative_count += 1
      end     
      #zone.reports_count  += 1 if flooded.in? [true, false] #it can only be  true or false, so that crappy (its an boolean)
      zone.reports_count  += 1
      zone.save
    end
  end

  scope :recent, ->{ where{created_at > WINDOW.hours.ago} }
  
  
  def classification
    flooded ? "flooded" : "dry"
  end

  def human_flooded
    flooded ? "ท่วม" : "ไม่ท่วม"
    end
  end

  def to_s
    comment
  end

  def blank?
    !flooded and comment.blank?
  end

  def as_json(options = {})
    super options.merge(except: [:ip_address, :author, :updated_at])
  end
end
