class AddCorrectOrderIndexToOption < ActiveRecord::Migration[5.0]
  def change
    add_column :forms_response_options, :correct_order_index, :integer
  end
end
