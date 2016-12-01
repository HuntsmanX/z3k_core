class Forms::Response::Section < ApplicationRecord
  extend FriendlyId
  friendly_id :uuid

  enum score_units: [:points, :percent]
  default_scope -> { order(:order_index) }

  before_create :generate_uuid

  belongs_to :response, class_name: 'Forms::Response',            inverse_of: :sections, counter_cache: true
  has_many   :questions, class_name: 'Forms::Response::Question', inverse_of: :section, dependent: :destroy
  has_many   :fields, through: :questions, class_name: 'Forms::Response::Field'
  accepts_nested_attributes_for :questions, allow_destroy: true

  validates :time_limit, numericality: true

  def next_section
    self.response.sections.where('order_index > ?', self.order_index).first
  end

  private

  def generate_uuid
    begin
      self.uuid = SecureRandom.urlsafe_base64 8
    end while self.class.exists?(uuid: self.uuid)
  end

end
