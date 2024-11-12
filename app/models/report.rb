class Report < ApplicationRecord
  belongs_to :user
  belongs_to :charity_project

  has_many_attached :photos, dependent: :destroy
  has_rich_text :body

  validates :title, presence: true, length: { maximum: 100 }
  validates :charity_project, presence: true
  validates :user, presence: true
  validates :report_type, presence: true, inclusion: { in: %w[article evaluation] }
  validate :check_evaluator_role
  validates :teaser, presence: true, length: { maximum: 300 }

  enum report_type: { article: 0, evaluation: 1 }


  private

  def check_evaluator_role
    if :report_type == 'evaluation'
      errors.add(:type, 'must be an evaluator') unless user.evaluator?
    end
  end
end
