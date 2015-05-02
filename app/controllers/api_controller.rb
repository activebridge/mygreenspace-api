class ApiController < ActionController::API
  # required for jbuilder and rspec-rails gems
  include ActionController::ImplicitRender
  include ActionController::Helpers
  include ActionController::Caching

  def current_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id)
  end
end
