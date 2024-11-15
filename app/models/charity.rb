class Charity < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :charity_projects, dependent: :destroy
  has_many_attached :photos, dependent: :destroy

  validates :name, presence: true

  def score
    score = 0
    charity_projects.each do |project|
      reports_sum_score = project.reports.where(report_type: "Evaluation").reduce(0) do |reports_sum, report|
        p report.score
        reports_sum += report.score
      end
      reports_sum = project.reports.where(report_type: "Evaluation").count
      reports_score = reports_sum_score / reports_sum
      score += reports_score
    end
    unless charity_projects.count == 0
      return ( score / charity_projects.count )
    else
      return score
    end
  end
end
