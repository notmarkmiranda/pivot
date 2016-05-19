class UserDeactivator

def self.call(current_user_id, deactivated_id)
  current_user = User.find(current_user_id)
  deactivated_user = User.find(deactivated_id)

  if user_deactivates_own_account(current_user_id, deactivated_id)
      current_user.loan_requests.update_all(active: false)
      current_user.loan_offers.update_all(active: false)
      current_user.active_update
      UserNotifier.unwelcome(current_user, current_user.email).deliver_now
  elsif is_admin?(current_user)
      deactivated_user.loan_requests.update_all(active: false)
      deactivated_user.loan_offers.update_all(active: false)
      UserNotifier.unwelcome(deactivated_user, deactivated_user.email).deliver_now
      deactivated_user.active_update
    end
end

def self.user_deactivates_own_account(current_user_id, deactivated_id)
  current_user_id.to_s == deactivated_id
end

def self.is_admin?(current_user)
  current_user.role == "admin"
end

end