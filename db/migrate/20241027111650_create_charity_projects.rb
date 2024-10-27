class CreateCharityProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :charity_projects do |t|
      t.string :name
      t.text :description
      t.string :location
      t.references :charity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
