class Forms::ResponseSerializer < ApplicationSerializer

  attributes :id,
    :name,
    :test_id,
    :user_id,
    :user_full_name_eng,
    :user_first_name_eng,
    :first_section_uid,
    :sections_count,
    :total_questions,
    :max_score,
    :user_score,
    :sections_count,
    :created_at_formatted,
    :checked,
    :successful

  has_many :sections, if: :include_nested?

  def user_full_name_eng
    object.user.full_name_eng
  end

  def user_first_name_eng
		object.user.first_name_eng
	end

	def first_section_uid
		object.sections&.first&.uuid
	end

  def created_at_formatted
    object.created_at.strftime '%d %B %Y'
  end

  def successful
	  object&.sections&.pluck(:is_successful).uniq.include?(false || nil) ? false : true
  end

end
