class Charity < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :charity_projects, dependent: :destroy

  validates :name, presence: true
end
