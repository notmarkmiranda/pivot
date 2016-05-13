require "rails_helper"

RSpec.feature "User can create a loan offer" do
  scenario "existing user can create loan offer" do
    create_user
    user = User.last
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    click_on "Create a Loan Offer"

    assert_equal new_loan_offer_path, current_path

    fill_in "Amount", with: "3000"
    fill_in "Rate", with: "20"
    fill_in "Term", with: "20"
    click_on "Let's Go!"

    offer = LoanOffer.last

    expect(current_path).to  eq("/#{user.username}/loan_offers/#{offer.id}")
    expect(page).to have_content(offer.amount)
    expect(page).to have_content(offer.rate)
    expect(page).to have_content(offer.term)

  end
end
