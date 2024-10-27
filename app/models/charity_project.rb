class CharityProject < ApplicationRecord
  belongs_to :charity
  has_many :donations, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
end
