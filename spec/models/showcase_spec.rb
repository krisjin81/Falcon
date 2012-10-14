require 'spec_helper'

describe Showcase do
  it "Should create one default showcase if it does not have one" do
    acc = Account.new(:email => "foo@gmail.com", :username => "foobar" , :password=> "foobar12345",:free_member_level=>'New Member')
    acc.save!
    acc.has_default_showcase?.should be_true
  end

  it "Should create the default showcase with the proper name" do
    acc = Account.new(:email => "foo@gmail.com", :username => "foobar" , :password=> "foobar12345",:free_member_level=>'New Member')
    acc.save!
    def_showcase = acc.default_showcase
    def_showcase.name.should == "foobar's Showcase"
  end



  it "Should not be possible to create multiple default showcases" do
    acc = Account.new(:email => "foo@gmail.com", :username => "foobar" , :password=> "foobar12345",:free_member_level=>'New Member')
    acc.save!
    acc.should be_valid
    acc.showcases << acc.showcases.create!(:name => "foobar", :publicly_visible => true, :default => true )
    acc.should_not be_valid
  end

  it "Should not be possible to delete the default showcase" do
    acc = Account.new(:email => "foo@gmail.com", :username => "foobar" , :password=> "foobar12345",:free_member_level=>'New Member')
    acc.save!
    acc.should be_valid
    def_showcase = acc.default_showcase
    def_showcase.delete
    acc.has_default_showcase?.should be_true
  end

end
