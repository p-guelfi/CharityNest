class Report < ApplicationRecord
  belongs_to :user
  belongs_to :charity_project

  has_many_attached :photos, dependent: :destroy
  has_rich_text :body

  validates :title, presence: true, length: { maximum: 30 }
  validates :charity_project, presence: true
  validates :user, presence: true
  validates :type, presence: true, inclusion: { in: %w[article evaluation] }
  validate :check_evaluator_role
  validates :teaser, presence: true, length: { maximum: 200 }

  enum type: { article: 0, evaluation: 1 }


  private

  def check_evaluator_role
    if :type == 'evaluation'
      errors.add(:type, 'must be an evaluator') unless user.evaluator?
    end
  end
end
