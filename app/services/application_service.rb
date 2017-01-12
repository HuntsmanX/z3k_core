# Abstract class
class ApplicationService

	def call
		success, data = perform
		success ? ServiceResult.success(data) : ServiceResult.fail(data)
	end

	private

	def perform(attrs=nil)
		raise Exception.new('perform method must be implemented by the child class')
	end

end