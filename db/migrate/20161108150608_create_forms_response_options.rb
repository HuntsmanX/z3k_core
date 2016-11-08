class CreateFormsResponseOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_response_options do |t|
      t.string     :content
      t.boolean    :is_correct
      t.integer    :field_id
      t.integer    :order_index
      t.boolean    :user_selected
      t.belongs_to :forms_response_field
      t.timestamps
    end
  end
end
