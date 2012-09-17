require 'spec_helper'
require Rails.root.to_s + '/spec/RSpecExtensions'

describe "Dashboard" do

  before(:all) do
    20.times {FactoryGirl.create(:volunteer)}
    Volunteer.create(:name => "Max Purple", :email => "MaxPurple@example.com", :id => 444)
    Volunteer.create(:name => "Kory Lined", :email => "KoryLined@example.com", :id => 445)
  end

  after(:all) do
    Volunteer.delete_all
    WebformSubmittedData.delete_all
  end

  describe "Name Filter" do

    it "should filter and only show volunteer profiles whose name contains 'Max'" do
      visit volunteers_path

      fill_in "name", with: "Max"
      click_button 'Filter'
      page.should have_selector('.volunteer', :count => 1)

      page.should have_selector('title', text: "SC4G")
      page.should have_content('Max Purple')
      page.should_not have_content('Kory Lined')
    end
  end

  describe "Email Filter" do

    it "should filter and only show volunteer profiles whose email contains 'MaxPurple@example.com'" do
      visit volunteers_path

      fill_in "email", with: "MaxPurple@example.com"
      click_button 'Filter'
      page.should have_selector('.volunteer', :count => 1)

      page.should have_selector('title', text: "SC4G")
      page.should have_content('Max Purple')
      page.should_not have_content('Kory Lined')
    end
  end

  describe "Company Filter" do
    before(:each) do
      Volunteer.create(:name => "Tim Ombusa", :email => "TimOmbusa@example.com", :id => 446)
      FactoryGirl.create( :ws_company, data: "ThoughtWorks", sid: 446 )
    end

    it "should filter and only show profiles who have company 'ThoughtWorks'" do
      visit volunteers_path

      fill_in "company", with: "ThoughtWorks"
      click_button 'Filter'
      page.should have_selector('.volunteer', :count => 1)

      page.should have_selector('title', text: "SC4G")
      page.should have_content('Tim Ombusa')
      page.should_not have_content('Kory Lined')
    end
  end

  #describe "Skills Filter" do
  #  before(:each) do
  #    Volunteer.create(:name => "Tim Ombusa", :email => "TimOmbusa@example.com", :id => 446)
  #    FactoryGirl.create( :ws_company, data: "ThoughtWorks", sid: 446 )
  #    FactoryGirl.create( :ws_skills_Product_Management, sid: 446 )
  #  end
  #
  #  it "should filter and only show profiles who have skill 'Product Management'" do
  #    visit volunteers_path
  #
  #    click_button('Skills')
  #
  #    find(:css, "#skills_[value='Product Management']").set(true)
  #
  #    click_button 'Filter'
  #    page.should have_selector('.volunteer', :count => 1)
  #
  #    page.should have_selector('title', text: "SC4G")
  #    page.should have_content('Tim Ombusa')
  #    page.should_not have_content('Kory Lined')
  #  end
  #end






end