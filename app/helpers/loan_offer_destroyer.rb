class LoanOfferDestroyer

  def self.call(user_id, loan_offer_id)
    user = User.find(user_id)
    loan_offer = LoanOffer.find(loan_offer_id)
    if user && !is_admin?(user)
      user.loan_offers.delete(loan_offer_id)
    elsif is_admin?(user)
      user = loan_offer.user
      loan_offer.destroy
    end
  end

  def self.is_admin?(user)
    user.role == "admin"
  end

end