class AddCounterCacheColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :forms_test_sections, :questions_count, :integer
  end
end
