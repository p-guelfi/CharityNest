class CharityProject < ApplicationRecord
  belongs_to :charity
  has_many :donations, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :users, through: :donations
  has_many_attached :photos, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
end
