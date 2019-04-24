require "application_system_test_case"

class MonetaryAccountsTest < ApplicationSystemTestCase
  setup do
    @monetary_account = monetary_accounts(:one)
  end

  test "visiting the index" do
    visit monetary_accounts_url
    assert_selector "h1", text: "Monetary Accounts"
  end

  test "creating a Monetary account" do
    visit monetary_accounts_url
    click_on "New Monetary Account"

    fill_in "Account", with: @monetary_account.account_id
    fill_in "User", with: @monetary_account.user_id
    click_on "Create Monetary account"

    assert_text "Monetary account was successfully created"
    click_on "Back"
  end

  test "updating a Monetary account" do
    visit monetary_accounts_url
    click_on "Edit", match: :first

    fill_in "Account", with: @monetary_account.account_id
    fill_in "User", with: @monetary_account.user_id
    click_on "Update Monetary account"

    assert_text "Monetary account was successfully updated"
    click_on "Back"
  end

  test "destroying a Monetary account" do
    visit monetary_accounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Monetary account was successfully destroyed"
  end
end
