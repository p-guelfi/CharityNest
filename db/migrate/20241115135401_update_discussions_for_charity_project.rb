class UpdateDiscussionsForCharityProject < ActiveRecord::Migration[7.1]
  def change
    # Remove the donation_id column if it exists
    remove_column :discussions, :donation_id, :integer, if_exists: true

    # Add the charity_project_id column only if it doesn't already exist
    unless column_exists? :discussions, :charity_project_id
      add_reference :discussions, :charity_project, foreign_key: true
    end
  end
end
