class AddBonusTimeToResponseSection < ActiveRecord::Migration[5.0]
  def change
    add_column :forms_response_sections, :bonus_time, :integer
  end
end
