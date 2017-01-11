class ServiceResult
	attr_accessor :result, :success

	def initialize(payload, success)
		@success = success
		@result  = payload
	end

	private

	def self.success(payload)
		new payload, true
	end

	def self.fail(errors)
		@result = parse_active_model_errors(errors) if errors.is_a? ActiveModel::Errors
	end

	def parse_active_model_errors(errors)
		errors.messages
	end
end