class Category < ApplicationRecord
  has_many :charities
  has_many :charity_projects, through: :charities

  validates :name, presence: true, uniqueness: true
end
