class CreateCommands < ActiveRecord::Migration[5.0]
  def change
    create_table :commands do |t|
      t.string :name
      t.string :find_names, array: true, default: []
      t.string :created
      t.integer :sport_id
      t.integer :api_xbet_id

      t.timestamps
    end
  end
end
