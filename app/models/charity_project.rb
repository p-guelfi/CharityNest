class CharityProject < ApplicationRecord
  belongs_to :charity
  has_one :category, through: :charity
  has_many :donations, dependent: :destroy

  has_many :discussions, dependent: :destroy
  has_many :reports, dependent: :destroy

  has_many :discussions
  has_many :users, through: :donations
  has_many_attached :photos, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true

  def evaluations
    reports.where(report_type: "Evaluation")
  end

  def articles
    reports.where(report_type: "Article")
  end

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description, :location],
    associated_against: {
      charity: [:name, :description],
      category: :name
    },
    using: {
      tsearch: { prefix: true }
    }
end
