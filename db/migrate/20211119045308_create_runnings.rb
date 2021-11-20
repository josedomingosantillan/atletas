class CreateRunnings < ActiveRecord::Migration[5.0]
  def change
    create_table :runnings do |t|
      t.string :name
      t.string :one_lap
      t.string :two_lap
      t.string :three_lap
      t.string :total

      t.timestamps
    end
  end
end
