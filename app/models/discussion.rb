class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :charity_project
  has_many :comments, dependent: :destroy
end
