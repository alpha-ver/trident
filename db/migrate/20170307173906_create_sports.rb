class CreateSports < ActiveRecord::Migration[5.0]
  def change
    create_table :sports do |t|
      t.string  :name, default: nil, nill: false
      t.string  :find_names, array: true, default: []
      t.string  :created, default: nil
      t.boolean :enable, :default => true
      
      t.integer  :api_xbet_id
      t.json     :api_xbet_params   

      t.timestamps
    end
  end
end
