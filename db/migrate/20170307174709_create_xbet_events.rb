class CreateXbetEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :xbet_events do |t|
      t.integer   :champ_id
      t.integer   :const_id
      t.integer   :contora
      t.string    :dopinfo
      t.boolean   :finish
      t.integer   :maingame_id
      t.integer   :num
      t.integer   :period

      t.integer :host_command_id
      t.integer :slave_command_id
      t.integer :commands_ids
      t.integer :status
      t.json :score_history
      t.json :message_history
      t.json :dl
      t.datetime :start_at

      t.json :score

      t.timestamps
    end
  end
end
