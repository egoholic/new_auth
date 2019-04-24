class MonetaryAccount < ApplicationRecord
  belongs_to :user

  validates :account_id, presence: true, uniqueness: true  
end
