class ChangeRecurrentOfDonations < ActiveRecord::Migration[7.1]
  def change
    change_column :donations, :recurrent, :integer, :using => 'case when recurrent then 1 else 0 end'
  end
end
