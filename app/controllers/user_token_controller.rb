class UserTokenController < Knock::AuthTokenController

  before_action :authenticate

  private

  def authenticate
    is_entity_authenticated = entity.present? && entity.authenticate(auth_params[:password])

    unless is_entity_authenticated
      response = User.auth_on_staff({email: auth_params[:email], password: auth_params[:password]})
      entity.update_attribute(:password, auth_params[:password]) if response
      is_entity_authenticated = !!response
    end

    unless is_entity_authenticated
      raise Knock.not_found_exception_class
    end

  end

end
