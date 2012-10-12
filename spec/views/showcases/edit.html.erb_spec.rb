require 'spec_helper'

describe "showcases/edit" do
  before(:each) do
    @showcase = assign(:showcase, stub_model(Showcase,
      :name => "MyString",
      :content => "MyString",
      :publicly_visible => false,
      :account_id => 1
    ))
  end

  it "renders the edit showcase form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => showcases_path(@showcase), :method => "post" do
      assert_select "input#showcase_name", :name => "showcase[name]"
      assert_select "input#showcase_content", :name => "showcase[content]"
      assert_select "input#showcase_publicly_visible", :name => "showcase[publicly_visible]"
      assert_select "input#showcase_account_id", :name => "showcase[account_id]"
    end
  end
end
