RAILS_ROOT = Rails.root

task :run_tests => :environment do
  system "cd #{RAILS_ROOT} && rspec spec"
  system "cd #{RAILS_ROOT} && script/cucumber"
end