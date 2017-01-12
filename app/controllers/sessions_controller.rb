class SessionsController < DeviseTokenAuth::SessionsController

	def create
		result = StaffSignIn.new(params[:email], params[:password]).call

		render_create_error_bad_credentials and return unless result.successful?

		@resource = result.payload
		@client_id = SecureRandom.urlsafe_base64
		@token     = SecureRandom.urlsafe_base64

		@resource.tokens[@client_id] = {
			token:  BCrypt::Password.create(@token),
			expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
		}
		@resource.save

		sign_in(:user, @resource, store: false, bypass: false)

		yield @resource if block_given?

		render_create_success
	end

	def user_params
		params.require(:user).permit(:email, :password)
	end

end
