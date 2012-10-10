require 'cucumber'
require 'capybara-json'

Given /the following volunteers exist:/ do |table|
  table.hashes.each do |hash|
    Volunteer.create ({:id => hash['id'], :email => hash['email'], :name => hash['name']})
  end
end

Given /the following volunteers with time_submitted exist:/ do |table|
  table.hashes.each do |hash|
    value = WebformSubmission.new
    value.submitted = hash['time_submitted']
    Volunteer.create ({:id => hash['id'], :email => hash['email'], :name => hash['name'], :time_submitted_db => value})
  end
end

Given /the volunteer with id:(\d+) works at (.*)/ do |id, company|
  FactoryGirl.create( :ws_company, data: company, sid: id )
end

Given /the volunteer with id:(\d+) has ([A-Za-z_]+) skill([s]*)/ do |id, skill_name, _|
  factoryInstance = WebformSubmittedDataFactory.new()
  factoryInstance.createSkillFromName(id, skill_name)
end

Given /the volunteer with id:(\d+) is interested in ([A-Za-z_]+) org([s]*)/ do |id, org_name, _|
  factoryInstance = WebformSubmittedDataFactory.new()
  factoryInstance.createOrgFromName(id, org_name)
end

Given /the volunteer with id:(\d+) is interested in ([A-Za-z_]+) cause([s]*)/ do |id, cause_name, _|
  factoryInstance = WebformSubmittedDataFactory.new()
  factoryInstance.createCauseFromName(id, cause_name)
end

Given /the volunteer with id:(\d+) is interested in ([A-Za-z_]+) language([s]*)/ do |id, language_name, _|
  factoryInstance = WebformSubmittedDataFactory.new()
  factoryInstance.createLanguageFromName(id, language_name)
end

Given /the volunteer with id:(\d+) has ([A-Za-z_]+) time_to_commit([s]*)/ do |id, time_to_commit_name, _|
  factoryInstance = WebformSubmittedDataFactory.new()
  factoryInstance.createTimeToCommitFromName(id, time_to_commit_name)
end

Given /the volunteer with id:(\d+) has ([A-Za-z_]+) participated in open source([s]*)/ do |id, answer_name, _|
  factoryInstance = WebformSubmittedDataFactory.new()
  factoryInstance.createOpenSourceFromName(id, answer_name)
end

When /I visit "(.*?)"$/ do |page|
  @result = get page
end

Then /the JSON response should have (\d+) user([s]*)/ do |number, _|
  JSON.parse(@result.body).length.should == number.to_i
end

Then /the JSON response at row (\d+):(.+) should be ([A-Za-z0-9() ]*)/ do |id, param_name, value|
  parsed = JSON.parse(@result.body)
  puts parsed
  parsed[id.to_i][param_name].should == value
end