class TransactionService
  
  def initialize(params)
    @monetary_account = MonetaryAccount.find_by_account_id(params[:monetary_account])
  end
  
  def perform
    last_transaction
    fetch.each { |payment| create(payment) }
  end

  private

  def create(payment)
    transaction = Transaction.new(payment).save
  end

  def last_transaction
    @last_transaction ||= @monetary_account.transactions.order('transaction_time').last.bunq_id
  end

  def fetch
    payments = Bunq.client.me_as_user.monetary_account(@monetary_account.account_id).payments.index(count: 100).each_with_object([]) do |payment,transactions|
      if payment['Payment']['id'] == @last_transaction 
        return transactions 
      else 
        transactions << {
          bunq_id: payment['Payment']['id'],
          transaction_time: payment['Payment']['created'],
          monetary_account_id: @monetary_account.id,
          amount: payment['Payment']['amount']['value'],
          description: payment['Payment']['description'],
          transaction_type: payment['Payment']['type']
        }
      end
    end
  end
end