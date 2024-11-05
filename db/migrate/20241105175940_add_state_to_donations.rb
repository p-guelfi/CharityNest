class AddStateToDonations < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:donations, :state)
      add_column :donations, :state, :string
    end
  end
end
