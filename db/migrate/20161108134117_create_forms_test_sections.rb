class CreateFormsTestSections < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_test_sections do |t|
      t.integer  :test_id
      t.string   :title
      t.text     :description
      t.integer  :time_limit
      t.integer  :bonus_time
      t.integer  :required_score
      t.integer  :required_score_units
      t.integer  :acceptable_score
      t.integer  :acceptable_score_units
      t.integer  :order_index
      t.boolean  :shuffle_questions
      t.integer  :questions_to_show
      t.integer  :show_next_section

      t.timestamps null: false
    end
  end
end
