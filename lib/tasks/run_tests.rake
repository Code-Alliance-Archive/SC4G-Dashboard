task :run_tests => :environment do
  system "rspec spec"
  system "script/cucumber"
end