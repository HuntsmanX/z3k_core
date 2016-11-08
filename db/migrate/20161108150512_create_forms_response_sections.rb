class CreateFormsResponseSections < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_response_sections do |t|
      t.string     :title
      t.integer    :time_limit
      t.integer    :response_id
      t.text       :description
      t.integer    :required_score
      t.string     :uuid
      t.integer    :score_units
      t.integer    :order_index
      t.integer    :acceptable_score
      t.belongs_to :forms_response
      t.timestamps
    end
  end
end
