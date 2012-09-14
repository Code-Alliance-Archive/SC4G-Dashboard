require 'spec_helper'

describe 'Volunteer Page' do
  before { visit volunteers_path }

  it 'should have Name, Email, Company, Time to Commit, ect' do
    page.should have_selector('title', :text => 'SC4G')
  end

end