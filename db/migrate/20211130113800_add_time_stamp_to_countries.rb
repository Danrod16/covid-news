class AddTimeStampToCountries < ActiveRecord::Migration[6.1]
  def change
    add_column :countries, :last_update, :string
  end
end
