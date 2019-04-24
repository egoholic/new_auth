require 'test_helper'

class MonetaryAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monetary_account = monetary_accounts(:one)
  end

  test "should get index" do
    get monetary_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_monetary_account_url
    assert_response :success
  end

  test "should create monetary_account" do
    assert_difference('MonetaryAccount.count') do
      post monetary_accounts_url, params: { monetary_account: { account_id: @monetary_account.account_id, user_id: @monetary_account.user_id } }
    end

    assert_redirected_to monetary_account_url(MonetaryAccount.last)
  end

  test "should show monetary_account" do
    get monetary_account_url(@monetary_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_monetary_account_url(@monetary_account)
    assert_response :success
  end

  test "should update monetary_account" do
    patch monetary_account_url(@monetary_account), params: { monetary_account: { account_id: @monetary_account.account_id, user_id: @monetary_account.user_id } }
    assert_redirected_to monetary_account_url(@monetary_account)
  end

  test "should destroy monetary_account" do
    assert_difference('MonetaryAccount.count', -1) do
      delete monetary_account_url(@monetary_account)
    end

    assert_redirected_to monetary_accounts_url
  end
end
