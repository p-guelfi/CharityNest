class CreateCharities < ActiveRecord::Migration[7.1]
  def change
    create_table :charities do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
