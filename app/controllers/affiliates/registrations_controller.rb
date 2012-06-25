class Affiliates::RegistrationsController < Devise::RegistrationsController

  protected

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    super.tap do |resource|
      resource.build_business_profile unless resource.business_profile
    end
  end
end
