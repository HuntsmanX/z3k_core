class ChangeRequiredAndAcceptableScoreUnits < ActiveRecord::Migration[5.0]
  def change
    rename_column :forms_test_sections, :required_score_units, :required_score_unit
    rename_column :forms_test_sections, :acceptable_score_units, :acceptable_score_unit

    rename_column :forms_response_sections, :required_score_units, :required_score_unit
    rename_column :forms_response_sections, :acceptable_score_units, :acceptable_score_unit
  end
end
