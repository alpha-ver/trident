class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.string :group
      t.string :name
      t.string :type
      t.integer :v_i
      t.string :v_s
      t.text :v_t
      t.json :v_j
      t.boolean :v_b

      t.timestamps
    end
  end
end
