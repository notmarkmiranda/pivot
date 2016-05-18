class LoanRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :contract
  validates_presence_of :amount, :rate, :term

  def self.active_loan_requests
    LoanRequest.where(active:true).size
  end


end
