class Forms::ResponseSerializer < ApplicationSerializer

  attributes :id, :name, :created_at, :test_id, :user_id, :user_full_name_eng, :first_section_uid, :sections_count,
             :total_questions, :max_score, :user_score, :sections_count

  has_many :sections, if: :include_nested?

end
