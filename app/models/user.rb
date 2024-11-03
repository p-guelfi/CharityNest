class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { donor: 1, charity_admin: 2, evaluator: 3 }

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one :charity, dependent: :destroy
  has_many :donations
  has_many :orders

  # Optionally, you can add a validation to ensure that only admin users can create charities
  def can_create_charity?
    charity_admin?
  end
end
