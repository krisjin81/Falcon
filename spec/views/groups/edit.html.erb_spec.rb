require 'spec_helper'

describe "groups/edit" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :name => "MyString",
      :open_subscription => false,
      :community_group => false,
      :member_limit => 1,
      :owner_id => 1
    ))
  end

  it "renders the edit group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => groups_path(@group), :method => "post" do
      assert_select "input#group_name", :name => "group[name]"
      assert_select "input#group_open_subscription", :name => "group[open_subscription]"
      assert_select "input#group_community_group", :name => "group[community_group]"
      assert_select "input#group_member_limit", :name => "group[member_limit]"
      assert_select "input#group_owner_id", :name => "group[owner_id]"
    end
  end
end
