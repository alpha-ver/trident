class CreateBetTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :xbet_bettypes do |t|
      t.string  :name
      t.integer :col
      t.integer :colpos
      t.integer :groupnamevid
      t.integer :typeparam
      t.integer :betgroup_id


      t.timestamps
    end
  end
end
