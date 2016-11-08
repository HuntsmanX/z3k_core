class CreateFormsTestOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_test_options do |t|
      t.string     :content
      t.boolean    :is_correct
      t.integer    :field_id
      t.integer    :order_index
      t.belongs_to :forms_test_field
      t.timestamps
    end
  end
end
