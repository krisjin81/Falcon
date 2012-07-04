class Account::OmniauthCallbacksController < ApplicationController
  def facebook
    @account = Account.find_for_facebook_oauth(request.env["omniauth.auth"])
    if @account.valid?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", :kind => "Facebook")
      sign_in(@account, :event => :authentication)
      @redirect_path = after_sign_in_path_for(@account)
      respond_to do |format|
        format.js { render :action => 'success' }
        format.html { redirect_to @redirect_path }
      end
    else
      flash[:alert] = I18n.t("devise.omniauth_callbacks.failure", :kind => "Facebook", :reason => @account.errors.inspect)
      respond_to do |format|
        format.js { render :action => 'error' }
        format.html { redirect_to root_path }
      end
    end
  end
end
