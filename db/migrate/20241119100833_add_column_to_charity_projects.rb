class AddColumnToCharityProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :charity_projects, :description_steps, :text
    add_column :charity_projects, :description_impact, :text
    add_column :charity_projects, :description_scalability, :text
  end
end
