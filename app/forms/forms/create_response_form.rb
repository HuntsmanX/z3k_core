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
			result = ::Forms::DuplicateTestForResponse.new(testee_result.result, test_id)
			result.call.success.present? ? @response = result.response : self.errors.add(:response, result.result)
		else
			self.errors.add(:testee, testee_result.result)
		end
		self.errors.any? ? false : @response
  end

end
