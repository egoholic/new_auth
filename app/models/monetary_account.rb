class MonetaryAccount < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :account_id, presence: true, uniqueness: true  
end
