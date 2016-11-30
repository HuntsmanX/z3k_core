class AddFieldsToResponseSection < ActiveRecord::Migration[5.0]
  def change
    add_column :forms_response_sections, :acceptable_score_units, :integer
    add_column :forms_response_sections, :required_score_units,   :integer
    add_column :forms_response_sections, :show_next_section,      :integer
    add_column :forms_response_sections, :questions_to_show,      :integer
    add_column :forms_response_sections, :shuffle_questions,      :boolean
  end
end
