class User < ApplicationRecord
  has_secure_password
  has_many :monetary_accounts

  validates :email, presence: true, uniqueness: true  
end
