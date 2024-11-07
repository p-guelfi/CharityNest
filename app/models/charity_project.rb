class CharityProject < ApplicationRecord
  belongs_to :charity
  has_many :donations, dependent: :destroy
  has_many_attached :photos, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description, :location],
    associated_against: {
      charity: [:name, :description],
    },
    using: {
      tsearch: { prefix: true }
    }
end
