class Forms::Response::Section < ApplicationRecord
  extend FriendlyId
  friendly_id :uuid

  enum required_score_units:   [:points, :percent], _prefix: true
  enum acceptable_score_units: [:points, :percent], _prefix: true
  enum show_next_section:      [:show_next_depending_of_score, :show_next_regardless_of_score]

  default_scope -> { order(:order_index) }

  before_create :generate_uuid

  belongs_to :response, class_name: 'Forms::Response',           inverse_of: :sections
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
