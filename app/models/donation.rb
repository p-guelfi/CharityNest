class Donation < ApplicationRecord
  belongs_to :charity_project
  belongs_to :user

  # Monetize the amount attribute
  monetize :amount_cents

  # Validate the virtual attribute
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
