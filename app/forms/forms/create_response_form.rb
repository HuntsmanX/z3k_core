class Forms::CreateResponseForm

  include ActiveModel::Model
	include ActiveModel::Validations

  attr_accessor :test_id, :user_id

	validates :test_id, presence: true
	validates :user_id, presence: true

	def submit params
    assign_attributes params
    return false unless valid?
		persist
	end

  def model
    @response
  end

  private

  def persist
    testee    = ::Forms::FindOrInitTestee.new(@user_id).testee
		@response = ::Forms::DuplicateTestForResponse.new(testee, test_id).response
    @response.present?
  end

end
