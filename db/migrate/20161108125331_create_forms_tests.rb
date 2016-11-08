class CreateFormsTests < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_tests do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
