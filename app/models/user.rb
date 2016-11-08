class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  alias_method :authenticate, :valid_password?

  def self.from_token_request(request)
    email = request.params['auth'] && request.params['auth']['email']
    user = self.find_by email: email

    unless user
      user_from_staff = auth_on_staff(request.params['auth'])
      user = User.create(user_from_staff.merge(password: request.params['auth']['password'])) if user_from_staff.present?
    end

    user
  end

  def self.from_token_payload(payload)
    self.find payload['sub']
  end

  def self.auth_on_staff(params)
    staff_credentials = Rails.application.secrets.staff
    params.merge!(auth_token: staff_credentials['api_key'])
    response = nil

    RestClient.get(staff_credentials['url'] + '/api/auth', { params: params } ) do |r|
     response = (r.code == 200 ? JSON.parse(r.body) : nil)
    end

    decorate_response(response) if response
  end

  private

  def self.decorate_response(user_from_staff)
    user_from_staff.keep_if { |k,v| (User.column_names - ['id']).index k}
  end

end
