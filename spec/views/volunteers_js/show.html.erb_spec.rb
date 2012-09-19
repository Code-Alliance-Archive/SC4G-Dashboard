require 'spec_helper'

describe "volunteers_js/show" do
  before(:each) do
    @volunteers_j = assign(:volunteers_j, stub_model(VolunteersJ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
