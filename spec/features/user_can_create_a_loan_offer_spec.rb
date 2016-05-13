require "rails_helper"

RSpec.feature "User can create a loan offer" do
  scenario "existing user can create loan offer" do
    create_user
    user = User.last
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit '/'
    click_on "Create a Loan Request"

    assert_equal new_loan_request_path, current_path

    fill_in "Loan Amount", with: "3000"
    fill_in "Maximum Interest Rate", with: "20"
    click_on "Submit Loan Request"

    request = LoanRequest.last

    assert_equal "/#{user.username}/loan_requests/#{request.id}", current_path
    assert page.has_content? request.amount
    assert page.has_content? request.max_int_rate

  end
end
