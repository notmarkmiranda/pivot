class ContractsController < ApplicationController

  def new
    if current_user && session[:cart]
      cart = session[:cart].transform_keys { |k| k.to_sym }
      @loan_requests = cart[:requests].map { |lr| LoanRequest.find(lr) }
      @loan_offers = cart[:offers].map { |lo| LoanOffer.find(lo) }
    else
      render file: '/public/404'
    end
  end

  def create
    cart = session[:cart].transform_keys { |k| k.to_sym }
    ContractsCreator.call(cart, current_user)
    session[:cart]["requests"] = []
    session[:cart]["offers"] = []
    redirect_to user_contracts_path(current_user.username)
  end

  def destroy
    if current_admin?
      contract = Contract.find(params[:id])
      contract.update(active: false)
      redirect_to :back
    else
      flash[:error] = "Not allowed!"
    end
  end

  def index
    if current_admin?
      @active_contracts = Contract.all.where(active: true)
      @inactive_contracts = Contract.all.where(active: false)
    else
      render file: '/public/404'
    end
  end

  def reinstate
    if current_admin?
      contract = Contract.find(params[:id])
      contract.update(active: true)
      redirect_to :back
    else
      flash[:error] = "Not allowed!"
    end
  end

end
