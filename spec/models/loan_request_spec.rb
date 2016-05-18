require 'rails_helper'

RSpec.describe LoanRequest, type: :model do
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:rate) }

  it "can return active loan requests" do
    create_loan_request(1)
    expect(LoanRequest.active_loan_requests).to eq 1
    create_loan_request(2)
    expect(LoanRequest.active_loan_requests).to eq 3
    LoanRequest.last.update(active: false)
    expect(LoanRequest.active_loan_requests).to eq 2
  end




end
