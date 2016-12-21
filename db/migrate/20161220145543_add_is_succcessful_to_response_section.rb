class AddIsSucccessfulToResponseSection < ActiveRecord::Migration[5.0]
  def change
    add_column :forms_response_sections, :is_successful, :boolean
  end
end
