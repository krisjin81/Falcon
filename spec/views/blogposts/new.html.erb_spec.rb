require 'spec_helper'

describe "blogposts/new" do
  before(:each) do
    assign(:blogpost, stub_model(Blogpost,
      :content => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new blogpost form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blogposts_path, :method => "post" do
      assert_select "input#blogpost_content", :name => "blogpost[content]"
      assert_select "input#blogpost_user_id", :name => "blogpost[user_id]"
    end
  end
end
