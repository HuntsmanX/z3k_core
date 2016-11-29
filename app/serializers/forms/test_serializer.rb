class Forms::TestSerializer < ApplicationSerializer
  attributes :id, :name, :nums_of_sections, :total_questions, :max_score, :shuffle_questions, :time_limit

  has_many :sections, if: :include_nested?

  def nums_of_sections
    object.sections.size
  end

  def total_questions
    object.sections.map { |s| s.questions.size }.inject(:+) || 0
  end

  def max_score
    object.sections.map(&:questions).flatten.map(&:fields).flatten.map(&:score).inject(:+) || 0
  end

  def shuffle_questions
    shuffles = object.sections.map(&:shuffle_questions)

    return 'Yes' if shuffles.all? { |s| s }
    return 'No'  if shuffles.all? { |s| !s }

    'Yes / No'
  end

  def time_limit
    limits = object.sections.map(&:time_limit)

    return "Unlimited" if limits.all? { |l| l.nil? || l.zero? }

    total     = limits.compact.inject(:+)
    total_str = "#{total} #{'minute'.pluralize(total)}"

    return "#{total_str} / unlimited" if limits.any? { |l| l.nil? || l.zero? }

    total_str
  end
end
