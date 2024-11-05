class AddCheckoutToDonations < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:donations, :checkout_session_id)
      add_column :donations, :checkout_session_id, :string
    end
  end
end
