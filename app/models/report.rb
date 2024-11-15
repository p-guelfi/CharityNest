class Report < ApplicationRecord
  belongs_to :user
  belongs_to :charity_project

  has_many_attached :photos, dependent: :destroy
  has_rich_text :body

  validates :title, presence: true, length: { maximum: 100 }
  validates :charity_project, presence: true
  validates :user, presence: true
  validates :report_type, presence: true, inclusion: { in: %w[Article Evaluation] }
  validate :check_evaluation
  validates :teaser, presence: true, length: { maximum: 300 }

  enum report_type: { Article: 0, Evaluation: 1 }


  private

  def check_evaluation
    if :report_type == 'evaluation'
      errors.add(:type, 'must be an evaluator') unless user.evaluator?
      errors.add(:score, 'must be present') if score.nil?
      errors.add(:score_impact, 'must be present') if score_impact.nil?
      errors.add(:score_communication, 'must be present') if score_communication.nil?
      errors.add(:score_efficiency, 'must be present') if score_efficiency.nil?
      errors.add(:score_adaptability, 'must be present') if score_adaptability.nil?
      errors.add(:score, 'must be a number between 0 and 100') if score < 0 || score > 100
      errors.add(:score_impact, 'must be a number between 0 and 100') if score_impact < 0 || score_impact > 100
      errors.add(:score_communication, 'must be a number between 0 and 100') if score_communication < 0 || score_communication > 100
      errors.add(:score_efficiency, 'must be a number between 0 and 100') if score_efficiency < 0 || score_efficiency > 100
      errors.add(:score_adaptability, 'must be a number between 0 and 100') if score_adaptability < 0 || score_adaptability > 100
    end
  end
end
