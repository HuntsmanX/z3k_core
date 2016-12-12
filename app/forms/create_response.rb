class CreateResponse
	include ActiveModel::Validations

	validates :test_id, presence: true
	validates :user_id, presence: true

	attr_reader :params, :testee, :test_id, :user_id, :response

	def initialize(user_id, test_id)
		@test_id = test_id
		@user_id = user_id
		submit if valid?
	end

	def submit
		@testee   = ::Forms::FindOrInitTestee.new(@user_id).testee
		@response = ::Forms::DuplicateTestForResponse.new(@testee, @test_id).response if @testee
	end



end