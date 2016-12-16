module TestConcern
	extend ActiveSupport::Concern

	included do
		scope :with_nested, -> { includes(sections: [questions: [fields: :options]]) }
	end

	def total_questions
		self.sections.map { |s| s.questions.size }.inject(:+) || 0
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

	def sections_count
		self.sections.size
	end
end
