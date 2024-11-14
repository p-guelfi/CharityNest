class AddDonationRefToDiscussions < ActiveRecord::Migration[7.1]
  def change
    add_reference :discussions, :donation, foreign_key: true
    remove_reference :discussions, :charity_project, foreign_key: true
  end
end
