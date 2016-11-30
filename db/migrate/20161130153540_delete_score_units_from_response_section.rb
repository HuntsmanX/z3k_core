class DeleteScoreUnitsFromResponseSection < ActiveRecord::Migration[5.0]
  def change
    remove_column :forms_response_sections, :score_units, :integer
  end
end
