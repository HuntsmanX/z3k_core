class User < ApplicationRecord
  require 'z3k_transliterator.rb'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :responses, class_name: 'Forms::Response' #TODO: Add scope
  has_many :role_assignments
  has_many :roles, through: :role_assignments
  belongs_to :city

  before_save :set_timezone, :transliterate_name

  jsonb_accessor :names,
    first_name:     :string,
    first_name_eng: :string,
    last_name:      :string,
    last_name_eng:  :string

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

  def full_name_eng
    "#{first_name_eng} #{last_name_eng}"
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

end
