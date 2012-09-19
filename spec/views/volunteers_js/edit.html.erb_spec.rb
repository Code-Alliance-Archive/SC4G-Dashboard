require 'spec_helper'

describe "volunteers_js/edit" do
  before(:each) do
    @volunteers_j = assign(:volunteers_j, stub_model(VolunteersJ))
  end

  it "renders the edit volunteers_j form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => volunteers_js_path(@volunteers_j), :method => "post" do
    end
  end
end
