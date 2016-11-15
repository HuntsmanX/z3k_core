class AddForeignKeyToResponses < ActiveRecord::Migration[5.0]
  def change
    add_reference :forms_responses, :user, foreign_key: true
  end
end
