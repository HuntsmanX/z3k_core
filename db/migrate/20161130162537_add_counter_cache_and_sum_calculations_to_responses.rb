class AddCounterCacheAndSumCalculationsToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :forms_responses, :sections_count, :integer, default: 0
    add_column :forms_responses, :max_score,      :integer, default: 0
    add_column :forms_responses, :user_score,     :integer, default: 0
    add_column :forms_tests,     :sections_count, :integer, default: 0
    add_column :forms_tests,     :max_score,      :integer, default: 0
  end
end
