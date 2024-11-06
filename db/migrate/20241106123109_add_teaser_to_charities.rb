class AddTeaserToCharities < ActiveRecord::Migration[7.1]
  def change
    add_column :charities, :teaser, :text
  end
end
