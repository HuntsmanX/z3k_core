class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  require 'z3k_transliterator.rb'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :responses, class_name: 'Forms::Response' #TODO: Add scope
  has_many :role_assignments
  has_many :roles, through: :role_assignments
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
      params[:auth_token] = staff_credentials['api_key']
      response = nil

      RestClient.get(staff_credentials['url'] + 'api/auth', {params: {auth_token: staff_credentials['api_key'], email: params['email'], password: params['password']}}) do |r|
        response = (r.code == 200 ? JSON.parse(r.body) : nil)
      end

      unit_from_response(response,params) if response
    end

    def unit_from_response(response, params)
      response.merge!('password' => params['password'])
      find_or_create_user(response)
    end

  end

  def permissions
    roles.eager_load(:permissions).map(&:permissions).flatten
  end

  def permissions_combined
    permissions.map(&:combined)
  end

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end

  ransacker :first_name_eng do |parent|
    Arel::Nodes::InfixOperation.new '->>', parent.table[:names], Arel::Nodes.build_quoted('first_name_eng')
  end

  ransacker :last_name_eng do |parent|
    Arel::Nodes::InfixOperation.new '->>', parent.table[:names], Arel::Nodes.build_quoted('last_name_eng')
  end

  def full_name
    self.first_name_eng.to_s + ' ' + self.last_name_eng.to_s
  end

  def self.search(search)
    searchable = %w(first_name last_name first_name_eng last_name_eng)
    condition = ->(attr) { "(names ->> '#{attr}')" }
    query = searchable.map{|a| condition.call(a)}.join(' || ')

    if search
      where("#{query} ILIKE ?", "%#{search}%")
    else
      all
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
        self.first_name_eng = translated_name&.english
      end

      if last_name_changed?
        self.last_name_eng = Z3kTransliterator.transliterate(last_name)
      end

    end
  end

  def self.find_or_create_user(response)
    user = User.find_or_initialize_by(email: response['email']) do |user|
      user.password                = response['password']
      user.city_id                 = response['city_id']
      user.timezone                = response['timezone']
      user.created_at              = response['created_at']
      user.updated_at              = response['updated_at']
      user.staff_id                = response['id']
      user.names['last_name']      = response['profile']['last_name']
      user.names['first_name']     = response['profile']['first_name']
      user.names['last_name_eng']  = response['profile']['last_name_eng']
      user.names['first_name_eng'] = response['profile']['first_name_eng']
      user.avatar_url              = response['get_avatar_url']
    end
    user.skip_confirmation!
    user.save!
    user
  end

end
