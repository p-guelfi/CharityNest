class Order < ApplicationRecord
  belongs_to :user
  belongs_to :charity_project
  monetize :amount_cents
end
