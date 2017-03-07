class CreateBetCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :bet_companies do |t|
      t.string :name
      t.string :class
      t.text :about
      t.boolean :enable

      t.timestamps
    end
  end
end
