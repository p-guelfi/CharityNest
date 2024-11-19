class RenameColumnOfCharityProjects < ActiveRecord::Migration[7.1]
  def change
    rename_column :charity_projects, :description_long, :description_aim
  end
end
