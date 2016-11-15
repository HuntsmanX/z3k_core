class CreateTransliterations < ActiveRecord::Migration[5.0]
  def change
    create_table :transliterations do |t|
      t.string :russian
      t.string :english
    end
  end
end
