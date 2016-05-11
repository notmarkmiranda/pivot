class User::LoanRequestsController < User::BaseController

  def index
    @loan_requests = current_user.loan_requests
  end

  def show
    @user = current_user
    @loan_request = current_user.loan_requests.find(params[:id])
  end

  private

  def loan_request_params
    params.require(:loan_request).permit(:amount, :max_int_rate)
  end

end
