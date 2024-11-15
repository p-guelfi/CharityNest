class RenameTypeOfReports < ActiveRecord::Migration[7.1]
  def change
    rename_column :reports, :type, :report_type
  end
end
