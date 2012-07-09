class Account::OmniauthCallbacksController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:google]

  def facebook
    @account = Account.facebook_oauth(request.env["omniauth.auth"])
    respond_with(@account, Provider.translate(:facebook))
  end

  def twitter
    @account = Account.twitter_oauth(request.env["omniauth.auth"])
    respond_with(@account, Provider.translate(:twitter))
  end

  def google_oauth2
    @account = Account.google_oauth(request.env["omniauth.auth"])
    respond_with(@account, Provider.translate(:google))
  end

  private

  def respond_with(account, kind)
    if account.valid?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", :kind => kind)
      sign_in(account, :event => :authentication)
      @redirect_path = after_sign_in_path_for(account)
      respond_to do |format|
        format.js { render :action => 'success' }
        format.html { redirect_to @redirect_path }
      end
    else
      flash[:alert] = I18n.t("devise.omniauth_callbacks.failure", :kind => kind, :reason => account.errors.full_messages.join(","))
      respond_to do |format|
        format.js { render :action => 'failure' }
        format.html { redirect_to root_path }
      end
    end
  end
end
