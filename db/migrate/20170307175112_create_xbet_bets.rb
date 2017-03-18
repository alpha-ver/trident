class CreateXbetBets < ActiveRecord::Migration[5.0]
  def change
    create_table :xbet_bets do |t|
      t.integer :event_id
      t.integer :bettype_id
      t.float   :ratio
      t.boolean :active

      t.float   :p
      t.json    :pl
      #############

      t.json    :dl


      t.timestamps
    end
  end
end
