class CharityProject < ApplicationRecord
  belongs_to :charity
  has_one :category, through: :charity
  has_many :donations, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :comments, through: :discussions
  has_many :reports, dependent: :destroy
  has_many :users, through: :donations

  has_many_attached :photos, dependent: :destroy
  has_rich_text :description_long


  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true


  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

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
