class AddPartnerToCharities < ActiveRecord::Migration[7.1]
  def change
    add_column :charities, :partner, :string
  end
end
