class AddSuccessCriteriaToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :forms_responses, :success_criterion, :integer, default: Forms::Response.success_criterions[:total_score]
    add_column :forms_responses, :required_score, :integer, default: 0
    add_column :forms_responses, :required_score_unit, :integer, default: Forms::Response.required_score_units[:points]
    add_column :forms_responses, :successful_sections_count, :integer, default: 0
  end
end
