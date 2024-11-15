class AddColumnsToCharityProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :charity_projects, :description_long, :text
  end
end
