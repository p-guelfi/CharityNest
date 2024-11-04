class RemoveAmountFromDonations < ActiveRecord::Migration[7.1]
  def change
    remove_column :donations, :amount, :integer
  end
end
