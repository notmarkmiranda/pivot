class LoanRequestDestroyer

  def self.call(user_id, loan_request_id)
    user = User.find(user_id)
    loan_request = LoanRequest.find(loan_request_id)
    if user && !is_admin?(user)
      user.loan_requests.delete(loan_request_id)
    elsif is_admin?(user)
      user = loan_request.user
      loan_request.destroy
    end
  end

  def self.is_admin?(user)
    user.role == "admin"
  end

end