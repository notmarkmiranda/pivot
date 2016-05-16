class CartItemsController < ApplicationController

  def create
    set_redirect
    id, obj, valid, message = CartAddManager.call(request.referrer, params[:item_id], @cart.contents, current_user)
    if !valid
      flash[:now] = message
    else
      @cart.add_item(id, obj)
      session[:cart] = @cart.contents
      flash[:success] = message
      redirect_to session[:redirect]
    end
    
  end

  def index
    @items = @cart.mapped_values || [[],[]]
  end

  def destroy
    item = LoanRequest.find(params[:id])
    @cart.remove_item(params[:id])
    flash[:notice] = "Successfully removed <a href=\"/#{item.user.username}/loan_requests/#{item.id}\"> loan</a>!"
    redirect_to cart_path
  end
end
