class AddDefaultForUserScore < ActiveRecord::Migration[5.0]
  def change
    change_column_default :forms_response_fields, :user_score, 0
  end
end
