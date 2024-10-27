class Donation < ApplicationRecord
  belongs_to :charity_project
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
