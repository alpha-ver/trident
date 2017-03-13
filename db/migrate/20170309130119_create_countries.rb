class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :find_names, array: true, default: []
      t.string :created

      t.integer :api_xbet_id
      t.json    :api_xbet_params

      t.timestamps
    end
  end
end
