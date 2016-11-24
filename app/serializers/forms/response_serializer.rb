class Forms::ResponseSerializer < ApplicationSerializer
  attributes :id, :name, :created_at, :test_id, :user_id, :user_full_name_eng

  has_many :sections, if: :include_nested?

  def user_full_name_eng
    object.user.full_name
  end

end
