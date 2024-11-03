class AddFieldsToDonations < ActiveRecord::Migration[7.1]
  def change
    add_column :donations, :state, :string
    add_column :donations, :checkout_session_id, :string
  end
end
