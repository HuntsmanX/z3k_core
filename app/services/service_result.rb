class ServiceResult

	def initialize(success, data)
		@success = success
		success ? @data = data : @errors = data
	end

	def successful?
		success
	end

	def payload
		return nil unless successful?
		data
	end

	def error
		return nil if successful?
		formatted_errors
	end

	private

	attr_reader :success, :data, :errors

	def self.success(payload)
		new true, payload
	end

	def self.fail(errors)
		new false, errors
	end

	def formatted_errors
		return errors.messages if errors.is_a? ActiveModel::Errors
		errors
	end
end