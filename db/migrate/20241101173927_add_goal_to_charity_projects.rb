class AddGoalToCharityProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :charity_projects, :goal, :integer
  end
end
