class AddSuccessCriteriaToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :forms_tests, :success_criterion, :integer, default: Forms::Test.success_criterions[:total_score]
    add_column :forms_tests, :required_score, :integer, default: 0
    add_column :forms_tests, :required_score_unit, :integer, default: Forms::Test.required_score_units[:points]
    add_column :forms_tests, :successful_sections_count, :integer, default: 0
  end
end
