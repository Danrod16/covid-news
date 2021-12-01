class AddScoreToCountries < ActiveRecord::Migration[6.1]
  def change
    add_column :countries, :score, :float
  end
end
