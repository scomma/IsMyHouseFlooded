desc "Truncate recent report data"
task :truncate => :environment do
  Zone.all.map &:update_statistics!
end

task :generate_levels, [:hours] => :environment do |t, args|
  FloodLevel.create_all_between args[:hours].to_i.hours.ago, DateTime.now
end

task :cron => :environment do |t, args|
  Zone.all.map &:update_statistics!
  FloodLevel.create_all_between 1.hours.ago, DateTime.now
end
