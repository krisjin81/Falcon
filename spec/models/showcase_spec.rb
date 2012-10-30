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

  it "Should be possible to create new showcases if the user is S or M level" do
    acc = Account.new(:email => "foo@gmail.com", :username => "foobar" , :password=> "foobar12345",:free_member_level=>'Style Star')
    acc.save!
    acc.should be_valid
    acc.showcases << acc.showcases.create!(:name => "foobar", :publicly_visible => true, :default => false)
    acc.save!
    acc.should  be_valid
    acc.can_create_additional_showcases?.should be_true
    acc.showcases.count.should == 2
  end

  it "should not be possible to create new showcases if user is anything other than S or M level" do
    acc = Account.new(:email => "foo@gmail.com", :username => "foobar" , :password=> "foobar12345",:free_member_level=>'New Member')
    acc.save!
    acc.should be_valid
    acc.can_create_additional_showcases?.should be_false
#    acc.showcases << acc.showcases.create!(:name => "foobar", :publicly_visible => true, :default => false)
 #   acc.save!
 #   acc.should_not be_valid
  end





end
# == Schema Information
#
# Table name: showcases
#
#  id               :integer(4)      not null, primary key
#  name             :string(255)     not null
#  content          :string(255)
#  publicly_visible :boolean(1)      default(TRUE), not null
#  account_id       :integer(4)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  default          :boolean(1)      default(FALSE)
#  cover_picture_id :integer(4)
#

