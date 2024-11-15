class ChangeDiscussionAssociationToCharityProject < ActiveRecord::Migration[7.1]
  def change
    remove_reference :discussions, :donation, foreign_key: true
    add_reference :discussions, :charity_project, foreign_key: true
  end
end
