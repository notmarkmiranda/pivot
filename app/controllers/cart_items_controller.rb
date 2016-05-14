class CartItemsController < ApplicationController

  def create
    set_redirect
    item = LoanRequest.find(params[:item_id])
    @cart.add_item(params[:class], item.id)
    flash[:notice] = "Loan saved to cart."
    session[:cart] = @cart.contents
    redirect_to session[:redirect]
  end

  def index
    @items = @cart.mapped_values || {}
  end

  def update
    qty = params[:session][:quantity].to_i
    @cart.update(params[:item_id], qty)
    redirect_to cart_path
  end

  def destroy
    item = LoanRequest.find(params[:id])
    @cart.remove_item(params[:id])
    flash[:notice] = "Successfully removed <a href=\"/#{item.user.username}/loan_requests/#{item.id}\"> loan</a>!"
    redirect_to cart_path
  end
end
