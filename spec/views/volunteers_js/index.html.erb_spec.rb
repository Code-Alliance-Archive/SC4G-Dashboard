require 'spec_helper'

describe "volunteers_js/index" do
  before(:each) do
    assign(:volunteers_js, [
      stub_model(VolunteersJ),
      stub_model(VolunteersJ)
    ])
  end

  it "renders a list of volunteers_js" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
