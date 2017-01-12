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
		if testee_result.success.present?
			create_response = ::Forms::DuplicateTestForResponse.new(testee_result.result, test_id)
			duplicate_test_result(create_response)
		else
			self.errors.add(:testee, testee_result.result)
		end
		self.errors.any? ? false : @response
  end

	def duplicate_test_result(create_response)
		if create_response.call.success.present?
			@response = create_response.response
		else
			self.errors.add(:response, create_response.result)
		end
	end

end
