require "rails_helper"

RSpec.feature "Logged in admin can view user" do
  before(:each) do
    create_user(1,1)
    @admin,@user1 = create_user(1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(User.first)

    @loan_request = create_loan_request(3,@user1.id)
  end

  scenario "when they visit specified users page from users index" do
    expect(@user1.loan_requests.count).to eq(3)
    visit user_loan_request_path(@user1.username, @loan_request.first.id)

    click_button "Delete request"

    expect(current_paga th).to eq(user_path(@user1.id))
    expect(@user1.loan_requests.count).to eq(2)
  end
end
