class CreateFormsResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_responses do |t|
      t.string   :name
      t.integer  :test_id
      t.timestamps
    end
  end
end
