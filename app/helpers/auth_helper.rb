# app/helpers/auth_helper.rb
module AuthHelper
    def require_login
    end
  
    def logged_in?(user)
        if current_api_v1_user == user  then
            return true 
        else
            return false
        end
    end
end