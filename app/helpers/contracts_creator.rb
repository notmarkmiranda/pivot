class ContractsCreator

def self.call(cart, current_user)
  loan_requests = LoanRequest.find(cart[:requests])
  loan_offers = LoanOffer.find(cart[:offers])
    
    loan_requests.each do |lr|
      current_user.lent.create(loan_request_id: lr.id, borrower_id: lr.user_id) if lr.active
      borrower = User.find(lr.user_id)
      UserNotifier.contract_notice(current_user, borrower, current_user.email).deliver_now
      UserNotifier.contract_notice(borrower, current_user, borrower.email).deliver_now
      lr.update(active: false)
    end

    loan_offers.each do |lo|
      current_user.borrowed.create(loan_offer_id: lo.id, lender_id: lo.user_id) if lo.active
      lender = User.find(lo.user_id)
      UserNotifier.contract_notice(current_user, lender, current_user.email).deliver_now
      UserNotifier.contract_notice(lender, current_user, lender.email).deliver_now
      lo.update(active: false)
    end

end

end