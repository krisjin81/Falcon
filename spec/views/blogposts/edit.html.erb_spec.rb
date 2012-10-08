require 'spec_helper'

describe "blogposts/edit" do
  before(:each) do
    @blogpost = assign(:blogpost, stub_model(Blogpost,
      :content => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit blogpost form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blogposts_path(@blogpost), :method => "post" do
      assert_select "input#blogpost_content", :name => "blogpost[content]"
      assert_select "input#blogpost_user_id", :name => "blogpost[user_id]"
    end
  end
end
