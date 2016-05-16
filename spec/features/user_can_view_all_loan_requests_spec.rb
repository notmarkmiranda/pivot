require "rails_helper"

RSpec.feature "User can view all loan requests" do

    before(:each) do
      create_user(2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)
    end

    scenario "existing user can create loan request" do
        user = User.first
        create_loan_request(2)
        user.loan_requests = LoanRequest.all
        request = user.loan_requests.last
        user1 = User.last
        create_loan_request
        user1.loan_requests << LoanRequest.last
        request1 = user1.loan_requests.last

        visit loan_requests_path

        expect(page).to have_content ActionController::Base.helpers.number_to_currency(request.amount)
        expect(page).to have_content request.rate
        expect(page).to have_content ActionController::Base.helpers.number_to_currency(request1.amount)
        expect(page).to have_content request1.rate
    end
end
