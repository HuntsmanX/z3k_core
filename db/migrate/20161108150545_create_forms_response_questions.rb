class CreateFormsResponseQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_response_questions do |t|
      t.string     :content
      t.integer    :section_id
      t.integer    :order_index
      t.belongs_to :forms_response_section
      t.timestamps
    end
  end
end
