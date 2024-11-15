class AddDonationIdToDiscussions < ActiveRecord::Migration[7.1]
  def change
    add_column :discussions, :donation_id, :integer
  end
end
