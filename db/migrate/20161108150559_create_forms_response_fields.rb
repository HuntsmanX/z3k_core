class CreateFormsResponseFields < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_response_fields do |t|
      t.integer    :question_id
      t.integer    :field_type
      t.string     :block_key
      t.text       :content
      t.integer    :score
      t.boolean    :autocheck
      t.text       :user_content
      t.integer    :user_score
      t.boolean    :checked,      default: false
      t.belongs_to :forms_response_question
      t.timestamps
    end
  end
end
