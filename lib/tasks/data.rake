desc "Truncate recent report data"
task :truncate => :environment do
  Zone.all.map &:update_statistics!
end
