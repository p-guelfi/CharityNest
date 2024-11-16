class AddCoordinatesToCharityProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :charity_projects, :latitude, :float
    add_column :charity_projects, :longitude, :float
  end
end
