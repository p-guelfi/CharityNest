class AddMonetizedAmountToDonations < ActiveRecord::Migration[7.1]
  def change
    add_monetize :donations, :amount, currency: { present: false }
  end
end
