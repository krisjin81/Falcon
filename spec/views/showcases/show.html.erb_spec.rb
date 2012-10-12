require 'spec_helper'

describe "showcases/show" do
  before(:each) do
    @showcase = assign(:showcase, stub_model(Showcase,
      :name => "Name",
      :content => "Content",
      :publicly_visible => false,
      :account_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Content/)
    rendered.should match(/false/)
    rendered.should match(/1/)
  end
end
