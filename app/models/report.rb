class Report < ActiveRecord::Base
  belongs_to :zone, counter_cache: true
end
