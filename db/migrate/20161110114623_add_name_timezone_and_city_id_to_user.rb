class AddNameTimezoneAndCityIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :city_id, :integer
    add_column :users, :timezone, :string
    add_column :users, :names, :jsonb, default: { first_name: '', first_name_eng: '', last_name: '', last_name_eng: '' }
  end
end
