class AddSourceTypeAndSourceIdsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :source_type, :integer
    add_column :users, :staff_id, :integer
    add_column :users, :recruitment_id, :integer
  end
end
