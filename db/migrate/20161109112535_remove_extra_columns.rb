class RemoveExtraColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :forms_response_sections,  :forms_response_id,          :integer
    remove_column :forms_response_questions, :forms_response_section_id,  :integer
    remove_column :forms_response_fields,    :forms_response_question_id, :integer
    remove_column :forms_response_options,   :forms_response_field_id,    :integer
    remove_column :forms_test_questions,     :forms_test_section_id,      :integer
    remove_column :forms_test_fields,        :forms_test_question_id,     :integer
    remove_column :forms_test_options,       :forms_test_field_id,        :integer

    add_index :forms_responses,          :test_id
    add_index :forms_response_sections,  :response_id
    add_index :forms_response_questions, :section_id
    add_index :forms_response_fields,    :question_id
    add_index :forms_response_options,   :field_id
    add_index :forms_test_sections,      :test_id
    add_index :forms_test_questions,     :section_id
    add_index :forms_test_fields,        :question_id
    add_index :forms_test_options,       :field_id
  end
end
