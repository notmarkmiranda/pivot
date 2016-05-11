class User::LoanRequestsController < User::BaseController

  def new
    @loan_request = LoanRequest.new
  end

  def create
    @loan_request = LoanRequest.new(loan_request_params)
    @loan_request.user_id = current_user.id
    if @loan_request.save
      redirect_to user_loan_request_path(@loan_request)
    else
      flash[:now] = "Invalid Loan Request"
    end
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
