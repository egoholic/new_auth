class TransactionAccountValidator < ActiveModel::Validator
  def validate(record)
    if MonetaryAccount.find(record[:monetary_account_id]).nil?
      record.errors.add(:account_id, "No Monetary account with this bunq id")
    end
  end
end