class CreateConfigMistakeTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_config_mistake_types do |t|
      t.string :name
      t.string :color
      t.integer :penalty
    end
  end
end
