class CharityProject < ApplicationRecord
  belongs_to :charity
  has_many :donations, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many_attached :photos, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
end
