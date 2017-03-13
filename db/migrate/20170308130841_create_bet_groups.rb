class CreateBetGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :xbet_betgroups do |t|
      t.string   :name
      t.integer  :pos
      t.integer  :countcols

      t.timestamps
    end
  end
end
