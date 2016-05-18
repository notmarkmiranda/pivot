require 'rails_helper'

RSpec.describe LoanOffer, type: :model do
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:rate) }
  it { should validate_presence_of(:term) }

  it "can return active loan offers" do
    create_loan_offer(1)
    expect(LoanOffer.active_loan_offers).to eq 1
    create_loan_offer(2)
    expect(LoanOffer.active_loan_offers).to eq 3
    LoanOffer.last.update(active: false)
    expect(LoanOffer.active_loan_offers).to eq 2
  end

end
