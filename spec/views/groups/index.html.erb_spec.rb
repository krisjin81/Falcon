require 'spec_helper'

describe "groups/index" do
  before(:each) do
    assign(:groups, [
      stub_model(Group,
        :name => "Name",
        :open_subscription => false,
        :community_group => false,
        :member_limit => 1,
        :owner_id => 2
      ),
      stub_model(Group,
        :name => "Name",
        :open_subscription => false,
        :community_group => false,
        :member_limit => 1,
        :owner_id => 2
      )
    ])
  end

  it "renders a list of groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
