class MonetaryAccountsController < ApplicationController
  before_action :set_monetary_account, only: [:show, :edit, :update, :destroy]

  # GET /monetary_accounts
  # GET /monetary_accounts.json
  def index
    @available_accounts = fetch
    @available_accounts.each do |account| 
      monetary_account = MonetaryAccount.find_by_account_id(account[:bunq_id])
      if !monetary_account.nil?
          account[:user_id] = monetary_account.user_id
          account[:id] = monetary_account.id
      end
    end
  end

  # GET /monetary_accounts/1
  # GET /monetary_accounts/1.json
  def show
  end

  # GET /monetary_accounts/new
  def new
    @monetary_account = MonetaryAccount.new
  end

  # GET /monetary_accounts/1/edit
  def edit
  end

  def fetch
    Bunq.client.me_as_user.monetary_accounts.index.each_with_object([]) do |monetary_account, arr|
      account = {bunq_id: monetary_account['MonetaryAccountBank']['id'],
                name: monetary_account['MonetaryAccountBank']['description'],
                balance: monetary_account['MonetaryAccountBank']['balance']['value']
              }
      arr << account
    end
  end

  # POST /monetary_accounts
  # POST /monetary_accounts.json
  def create
    @monetary_account = MonetaryAccount.new

    respond_to do |format|
      if @monetary_account.save
        format.html { redirect_to @monetary_account, notice: 'Monetary account was successfully created.' }
        format.json { render :show, status: :created, location: @monetary_account }
      else
        format.html { render :new }
        format.json { render json: @monetary_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monetary_accounts/1
  # PATCH/PUT /monetary_accounts/1.json
  def update
    respond_to do |format|
      if @monetary_account.update(monetary_account_params)
        format.html { redirect_to @monetary_account, notice: 'Monetary account was successfully updated.' }
        format.json { render :show, status: :ok, location: @monetary_account }
      else
        format.html { render :edit }
        format.json { render json: @monetary_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monetary_accounts/1
  # DELETE /monetary_accounts/1.json
  def destroy
    @monetary_account.destroy
    respond_to do |format|
      format.html { redirect_to monetary_accounts_url, notice: 'Monetary account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monetary_account
      @monetary_account = MonetaryAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monetary_account_params
      params.require(:monetary_account).permit(:account_id, :user_id)
    end
end
