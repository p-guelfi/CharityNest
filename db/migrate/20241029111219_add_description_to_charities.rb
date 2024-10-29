class AddDescriptionToCharities < ActiveRecord::Migration[7.1]
  def change
    add_column :charities, :description, :string
  end
end
