class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :teaser
      t.text :content
      t.integer :type
      t.integer :score
      t.references :user, null: false, foreign_key: true
      t.references :charity_project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
