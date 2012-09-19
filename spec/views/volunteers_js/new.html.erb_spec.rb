require 'spec_helper'

describe "volunteers_js/new" do
  before(:each) do
    assign(:volunteers_j, stub_model(VolunteersJ).as_new_record)
  end

  it "renders new volunteers_j form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => volunteers_js_path, :method => "post" do
    end
  end
end
