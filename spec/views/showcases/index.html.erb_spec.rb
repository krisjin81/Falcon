require 'spec_helper'

describe "showcases/index" do
  before(:each) do
    assign(:showcases, [
      stub_model(Showcase,
        :name => "Name",
        :content => "Content",
        :publicly_visible => false,
        :account_id => 1
      ),
      stub_model(Showcase,
        :name => "Name",
        :content => "Content",
        :publicly_visible => false,
        :account_id => 1
      )
    ])
  end

  it "renders a list of showcases" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
