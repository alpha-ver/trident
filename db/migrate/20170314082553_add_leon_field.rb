class AddLeonField < ActiveRecord::Migration[5.0]
  def change

    add_column :sports, :api_leon_id, :integer
    add_column :sports, :api_leon_params, :json

    add_column :champs, :api_leon_id, :integer
    add_column :champs, :api_leon_params, :json

  end
end
