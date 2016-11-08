class CreateFormsTestQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_test_questions do |t|
      t.string     :content
      t.integer    :order_index
      t.integer    :section_id
      t.belongs_to :forms_test_section
      t.timestamps
    end
  end
end
