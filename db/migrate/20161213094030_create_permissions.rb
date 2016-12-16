class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.belongs_to :role, foreign_key: true
      t.string :key
      t.boolean :allowed
      t.jsonb :conditions

      t.timestamps
    end
  end
end
