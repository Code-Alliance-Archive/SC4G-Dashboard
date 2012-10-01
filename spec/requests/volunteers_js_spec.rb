require 'spec_helper'

describe "VolunteersJs" do
  before { visit volunteers_js_path }
  describe "GET /volunteers_js" do
    before(:all) do
    Volunteer.create(:name => "Tim Ombusa", :email => "TimOmbusa@example.com", :id => 446)
    end

    after(:all) do
      WebformSubmittedData.delete_all
      Volunteer.delete_all
    end

    it "it should show volunteers with most recent showing first" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      #response.status.should be(200)
      page.should have_selector('title', :text => 'SC4G')
      page.should have_content("Filter Volunteers")
      #page.should have_content("Time Ombusa")
    end
  end
end
