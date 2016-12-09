class SessionsController < DeviseTokenAuth::SessionsController
	def create
		@resource = User.find_by_email(params['email'])
		@resource = User.auth_on_staff(params) unless @resource.present?

		if @resource && @resource.valid_password?(params[:password])

			@client_id = SecureRandom.urlsafe_base64
			@token     = SecureRandom.urlsafe_base64

			@resource.tokens[@client_id] = {
					token: BCrypt::Password.create(@token),
					expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
			}

			@resource.save
			sign_in(:user, @resource, store: false, bypass: false)

			yield @resource if block_given?

			render_create_success
		end
	end

	def user_params
		params.require(:user).permit(:email, :password)
	end
end
