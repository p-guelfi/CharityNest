class AddStateToDonations < ActiveRecord::Migration[7.1]
  def change
    add_column :donations, :state, :string
  end
end
