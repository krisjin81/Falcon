class RegistrationsController < Devise::RegistrationsController
  protected

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    super.tap do |resource|
      resource.build_profile unless resource.profile
    end
  end
end
