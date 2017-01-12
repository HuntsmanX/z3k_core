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
    testee_result = ::Forms::FindOrInitTestee.new(@user_id).call
		if testee_result.successful?
			response_result = ::Forms::DuplicateTestForResponse.new(testee_result.payload, test_id).call
			duplicate_test_result(response_result)
		else
			self.errors.add(:testee, testee_result.error)
		end
		self.errors.any? ? false : @response
  end

	def duplicate_test_result(response_result)
		@response = response_result.payload if response_result.successful?
		self.errors.add(:response, response_result.error) unless response_result.successful?
	end

end
