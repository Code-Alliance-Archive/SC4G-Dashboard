require 'spec_helper'

describe 'Volunteer Page' do
  before { visit volunteers_path }

  it 'should have Name, Email, Company, Time to Commit, ect' do
    page.should have_selector('title', :text => 'SC4G')
  end

end


describe 'Volunteer Page json' do
  before(:each) do
    Volunteer.create(:name => "Tim Ombusa", :email => "TimOmbusa@example.com", :id => 446)
  end

  #use virtual girl here
  before { visit volunteers_path(:format => "json")}

  it 'should return some json' do
    page.should have_content "email"
  end
end