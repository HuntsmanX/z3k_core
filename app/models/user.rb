class User < ApplicationRecord
  require 'z3k_transliterator.rb'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :responses, class_name: 'Forms::Response' #TODO: Add scope
  belongs_to :city


  validates_presence_of :city


  before_create :set_timezone, :transliterate_name
  before_update :transliterate_name

  alias_method :authenticate, :valid_password?

  jsonb_accessor :names,
                 first_name: :string,
                 first_name_eng: :string,
                 last_name: :string,
                 last_name_eng: :string


  class << self

    def from_token_request(request)
      email = request.params['auth'] && request.params['auth']['email']
      user = find_by email: email

      unless user
        user_from_staff = auth_on_staff(request.params['auth'])
        user = User.create(user_from_staff.merge(password: request.params['auth']['password'])) if user_from_staff.present?
      end

      user
    end

    def from_token_payload(payload)
      find payload['sub']
    end

    def auth_on_staff(params)
      staff_credentials = Rails.application.secrets.staff
      params.merge!(auth_token: staff_credentials['api_key'])
      response = nil

      RestClient.get(staff_credentials['url'] + '/api/auth', {params: params}) do |r|
        response = (r.code == 200 ? JSON.parse(r.body) : nil)
      end

      decorate_response(response) if response
    end

  end

  private

  def set_timezone
    self.timezone = self.city.timezone
  end

  def transliterate_name
    if self.city.locale == 'EN'
      self.first_name = first_name_eng.strip
      self.last_name = last_name_eng.strip
    else
      if first_name_changed?
        first_name.strip!
        translated_name = Transliteration.where("UPPER(russian) = ?", first_name.mb_chars.upcase).first #TODO: add missing transliteration mailer
        self.first_name_eng = translated_name.english
      end

      if last_name_changed?
        self.last_name_eng = Z3kTransliterator.transliterate(last_name)
      end

    end
  end

  def self.decorate_response(user_from_staff)
    user_from_staff.keep_if { |k, v| (User.column_names - ['id']).index k }
  end

end
