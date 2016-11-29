class Forms::ResponseSerializer < ApplicationSerializer
  attributes :id, :name, :created_at, :test_id, :user_id, :user_full_name_eng, :first_section_uuid, :nums_of_sections,
             :total_questions, :max_score, :user_score

  has_many :sections, if: :include_nested?

  def user_full_name_eng
    object.user.full_name
  end

  def first_section_uuid
    object.sections.first.uuid
  end

  def nums_of_sections
    object.sections.size
  end

  def total_questions
    object.sections.map { |s| s.questions.size }.inject(:+) || 0
  end

  def max_score
    object.sections.map(&:questions).flatten.map(&:fields).flatten.map(&:score).inject(:+) || 0
  end

  def user_score
    object.sections.map(&:questions).flatten.map(&:fields).flatten.map(&:user_score).inject(:+) || 0
  end

end
