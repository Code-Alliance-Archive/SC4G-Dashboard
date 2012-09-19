require 'cucumber'
require 'capybara-json'

Given /the following volunteers exist:/ do |table|
  table.hashes.each do |hash|
    Volunteer.create ({:id => hash['id'], :email => hash['email'], :name => hash['name']})
  end
end

Given /the volunteer with id:(\d+) works at (.*)/ do |id, company|
  FactoryGirl.create( :ws_company, data: company, sid: id )
end

Given /the volunteer with id:(\d+) has ([A-Za-z_]+) skill([s]*)/ do |id, skill_name, _|
  factoryInstance = WebformSubmittedDataFactory.new()
  factoryInstance.createSkillFromName(id, skill_name)
end

When /I visit "(.*?)"$/ do |page|
  @result = get page
end

Then /the JSON response should have (\d+) user([s]*)/ do |number, _|
  JSON.parse(@result.body).length.should == number.to_i
end

Then /the JSON response at row (\d+):(.+) should be ([A-Za-z ]*)/ do |id, param_name, value|
  parsed = JSON.parse(@result.body)
  puts parsed
  parsed[id.to_i][param_name].should == value
end