class ChangeStatusOfDonations < ActiveRecord::Migration[7.1]
  def change
    change_column :donations, :status, :boolean, using: 'case when status = 0 then false else true end'
    rename_column :donations, :status, :recurrent
  end
end
