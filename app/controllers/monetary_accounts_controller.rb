class MonetaryAccountsController < ApplicationController
  before_action :set_monetary_account, only: [:show, :edit, :update, :destroy]

  def index
    @monetary_account = MonetaryAccount.new
    @available_accounts = fetch
    @available_accounts.each do |account| 
      monetary_account = MonetaryAccount.find_by_account_id(account[:account_id])
      if !monetary_account.nil?
          account[:user_id] = monetary_account.user_id
          account[:id] = monetary_account.id
      end
    end
  end

  def show
  end

  def new
    @monetary_account = MonetaryAccount.new
  end

  def edit
  end

  def create
    @monetary_account = MonetaryAccount.new(monetary_account_params)
    

    respond_to do |format|
      if @monetary_account.save
        format.html { redirect_to @monetary_account, notice: 'Monetary account was successfully created.' }
        format.json { render :show, status: :created, location: @monetary_account }
      else
        format.html { render :new }
        format.json { render json: @monetary_account.errors, status: :unprocessable_entity }
        puts @monetary_account.errors.full_messages
      end
    end
  end

  private

  def fetch
    Bunq.client.me_as_user.monetary_accounts.index.each_with_object([]) do |monetary_account, arr|
      account = {account_id: monetary_account['MonetaryAccountBank']['id'],
                name: monetary_account['MonetaryAccountBank']['description'],
                balance: monetary_account['MonetaryAccountBank']['balance']['value']
              }
      arr << account
    end
  end

  def set_monetary_account
    @monetary_account = MonetaryAccount.find(params[:id])
  end

  def monetary_account_params
    params.require(:monetary_account).permit(:account_id, :user_id, :name)
  end
end
