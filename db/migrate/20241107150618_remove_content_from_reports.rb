class RemoveContentFromReports < ActiveRecord::Migration[7.1]
  def change
    remove_column :reports, :content, :string
  end
end
