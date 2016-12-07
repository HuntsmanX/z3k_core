class ChangeResponseFieldScoreToFloat < ActiveRecord::Migration[5.0]
  def up
    change_column :forms_response_fields, :user_score, :float
  end

  def down
    change_column :forms_response_fields, :user_score, :integer
  end
end
