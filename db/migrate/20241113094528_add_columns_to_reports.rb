class AddColumnsToReports < ActiveRecord::Migration[7.1]
  def change
    add_column :reports, :score_impact, :integer
    add_column :reports, :score_communication, :integer
    add_column :reports, :score_efficiency, :integer
    add_column :reports, :score_adaptability, :integer
  end
end
