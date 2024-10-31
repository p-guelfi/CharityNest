class ChangeRecurrentNameOfDonations < ActiveRecord::Migration[7.1]
  def change
    rename_column :donations, :recurrent, :status
  end
end
