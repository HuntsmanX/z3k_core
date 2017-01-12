class StaffSignIn < ApplicationService

  def initialize email, password
    @email             = email
    @password          = password
    @staff_credentials = Rails.application.secrets.staff
  end

  def perform
    sign_in
    error ? [false, error] : [true, user_from_response]
  end

  def sign_in
    RestClient.get(sign_in_url, { params: sign_in_params }) do |r|
      r.code == 200 ? self.response = JSON.parse(r.body) : self.error = 'Invalid Credentials'
    end
    response && user_from_response
  end

  private

  attr_reader :email, :password, :staff_credentials, :response
  attr_accessor :error

  def sign_in_url
    staff_credentials['url'] + 'api/auth'
  end

  def sign_in_params
    {
      auth_token: staff_credentials['api_key'],
      email:      email,
      password:   password
    }
  end

  def response= response
    @response = OpenStruct.new(response).tap do |r|
      r.profile  = OpenStruct.new response['profile']
      r.password = password
    end
  end

  def user_from_response
    user = User.find_or_create_by email: response.email
    update_attributes user
    user
  end

  def update_attributes user
    user.update_attributes({
      staff_id:   response.id,
      password:   response.password,
      city_id:    response.city_id,
      avatar_url: response.avatar_url,
      names:      {
        first_name:     response.profile.first_name,
        last_name:      response.profile.last_name,
        first_name_eng: response.profile.first_name_translit,
        last_name_eng:  response.profile.last_name_translit
      }
    })
  end

end
