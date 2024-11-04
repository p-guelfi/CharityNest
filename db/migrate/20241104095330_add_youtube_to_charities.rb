class AddYoutubeToCharities < ActiveRecord::Migration[7.1]
  def change
    add_column :charities, :youtube_id, :string
  end
end
