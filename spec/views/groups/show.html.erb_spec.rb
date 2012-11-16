require 'spec_helper'

describe "groups/show" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :name => "Name",
      :open_subscription => false,
      :community_group => false,
      :member_limit => 1,
      :owner_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
