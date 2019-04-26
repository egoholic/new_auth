class Transaction < ApplicationRecord
  belongs_to :monetary_account

  validates_with TransactionAccountValidator
  validates :amount, :description, :transaction_time, :bunq_id, presence: true
  validates :bunq_id, uniqueness: true
end
