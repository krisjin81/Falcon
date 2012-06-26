class Affiliates::RegistrationsController < Devise::RegistrationsController

  before_filter :initialize_humanizer, :only => [:new, :create]

  def create
    build_resource

    if resource.bypass_humanizer or session[:human] or @humanizer.score_result(params[:session_secret], request.remote_ip)
      session[:human] = true
      super
    else
      resource.errors.add :base, I18n.t('helpers.human_detector_error')
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    super.tap do |resource|
      resource.build_business_profile unless resource.business_profile
    end
  end

  # Initializes human detector.
  #
  def initialize_humanizer
    @humanizer = AYAH::Integration.new(CAPTCHA[:publisher_key], CAPTCHA[:scoring_key]) unless session[:human]
  end
end
