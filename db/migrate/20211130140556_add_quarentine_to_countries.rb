class AddQuarentineToCountries < ActiveRecord::Migration[6.1]
  def change
    add_column :countries, :quarentine, :boolean
  end
end
