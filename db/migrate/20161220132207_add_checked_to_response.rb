class AddCheckedToResponse < ActiveRecord::Migration[5.0]
  def change
    add_column :forms_responses, :checked, :boolean
  end
end
