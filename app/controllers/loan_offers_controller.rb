class LoanOffersController < ApplicationController

  def index
    @loan_offers = LoanOffer.where(active: true)
  end

  def new
    if current_user && !current_admin?
      @loan_offer = LoanOffer.new
    else
      redirect_to login_path
    end
  end

  def create
    loan_offer = LoanOffer.new(loan_offer_params)
    if current_user.loan_offers << loan_offer
      redirect_to user_loan_offer_path(current_user.username, loan_offer.id), success: "yay!"
    else
      redirect_to new_loan_offer_path, error: loan_offer.errors.full_messages.join(", ")
    end
  end

  def edit
    @loan_offer = current_user.loan_offers.find(params[:id])
  end

  def update
    loan_offer = current_user.loan_offers.find(params[:id])
    if loan_offer.update(loan_offer_params)
      redirect_to user_loan_offer_path(current_user.username, loan_offer.id)
    else
      redirect_to new_loan_offer_path, error: loan_offer.errors.full_messages.join(", ")
    end
  end

  def destroy
    owner = LoanOffer.find(params[:id]).user
    LoanOfferDestroyer.call(current_user.id, params[:id])
    if current_user && !current_admin?
      redirect_to user_loan_offers_path(current_user.username), danger: "Loan Offer Deleted!"
    elsif current_admin?
      redirect_to user_path(owner.username)
    else
      redirect_to "/", danger: "Access Denied"
    end
  end

  private

  def loan_offer_params
    params.require(:loan_offer).permit(:rate,
                                        :term,
                                        :amount)
  end
end
