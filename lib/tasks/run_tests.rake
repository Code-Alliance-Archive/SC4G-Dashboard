RAILS_ROOT = Rails.root

task :run_tests => :environment do
  system "cd #{RAILS_ROOT} && rake db:drop:all && rake db:create:all && rake db:migrate && rake db:test:prepare"
  system "cd #{RAILS_ROOT} && rspec spec"
  system "cd #{RAILS_ROOT} && script/cucumber"
end