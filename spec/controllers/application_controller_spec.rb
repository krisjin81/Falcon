require 'spec_helper'

describe ApplicationController do
  describe "current_user" do
    it "returns current_account if account is logged in" do
      account = create(:account)

      controller.stub(:current_account).and_return(account)
      controller.stub(:current_affiliate).and_return(nil)

      controller.send(:current_user).should == account
    end

    it "returns current_affiliate if affiliate is logged in" do
      affiliate = create(:affiliate)

      controller.stub(:current_account).and_return(nil)
      controller.stub(:current_affiliate).and_return(affiliate)

      controller.send(:current_user).should == affiliate
    end

    it "returns blank if nobody is logged in" do
      controller.stub(:current_user).and_return(nil)
      controller.stub(:current_affiliate).and_return(nil)

      controller.send(:current_user).should be_blank
    end
  end

  describe "user_signed_in?" do
     it "returns true if account is logged in" do
       account = create(:account)

       controller.stub(:current_account).and_return(account)
       controller.stub(:current_affiliate).and_return(nil)

       controller.send(:user_signed_in?).should be_true
     end

     it "returns true if affiliate is logged in" do
       affiliate = create(:affiliate)

       controller.stub(:current_account).and_return(nil)
       controller.stub(:current_affiliate).and_return(affiliate)

       controller.send(:user_signed_in?).should be_true
     end

     it "returns false if nobody is logged in" do
       controller.stub(:current_user).and_return(nil)
       controller.stub(:current_affiliate).and_return(nil)

       controller.send(:user_signed_in?).should be_false
     end
  end

  describe "current_user_type" do
     it "returns :account if account is logged in" do
       account = create(:account)

       controller.stub(:current_account).and_return(account)
       controller.stub(:current_affiliate).and_return(nil)

       controller.send(:current_user_type).should == :account
     end

     it "returns :affiliate if affiliate is logged in" do
       affiliate = create(:affiliate)

       controller.stub(:current_account).and_return(nil)
       controller.stub(:current_affiliate).and_return(affiliate)

       controller.send(:current_user_type).should  == :affiliate
     end

     it "returns :guest if nobody is logged in" do
       controller.stub(:current_user).and_return(nil)
       controller.stub(:current_affiliate).and_return(nil)

       controller.send(:current_user_type).should  == :guest
     end
  end
end
