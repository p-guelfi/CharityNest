class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :donation
  has_many :comments, dependent: :destroy

  # Optional: Delegate access to the associated charity project via donation
  delegate :charity_project, to: :donation
end
