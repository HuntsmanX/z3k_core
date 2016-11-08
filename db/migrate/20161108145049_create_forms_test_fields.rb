class CreateFormsTestFields < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_test_fields do |t|
      t.integer    :question_id
      t.integer    :field_type
      t.string     :block_key
      t.text       :content
      t.integer    :score
      t.boolean    :autocheck
      t.belongs_to :forms_test_question
      t.timestamps
    end
  end
end
