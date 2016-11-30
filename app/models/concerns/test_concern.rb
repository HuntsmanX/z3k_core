module TestConcern
	extend ActiveSupport::Concern

	def user_full_name_eng
		self.user.full_name
	end

	def first_section_uid
		self.sections&.first&.uuid
	end

	def sections_count
		self.sections.size
	end

	def total_questions
		self.sections.map { |s| s.questions.size }.inject(:+) || 0
	end

	def max_score
		fields_array.flatten.map(&:score).inject(:+) || 0
	end

	def user_score
		fields_array.flatten.map(&:user_score).inject(:+) || 0
	end

	def fields_array
		self.sections.map(&:questions).flatten.map(&:fields)
	end

	def shuffle_questions
		shuffles = self.sections.map(&:shuffle_questions)

		return 'Yes' if shuffles.all? { |s| s }
		return 'No'  if shuffles.all? { |s| !s }

		'Yes / No'
	end

	def time_limit
		limits = self.sections.map(&:time_limit)

		return "Unlimited" if limits.all? { |l| l.nil? || l.zero? }

		total     = limits.compact.inject(:+)
		total_str = "#{total} #{'minute'.pluralize(total)}"

		return "#{total_str} / unlimited" if limits.any? { |l| l.nil? || l.zero? }

		total_str
	end
end
