class AdPcrToCountries < ActiveRecord::Migration[6.1]
  def change
    add_column :countries, :pcr_needed, :boolean
  end
end
