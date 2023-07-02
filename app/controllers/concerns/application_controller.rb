class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        include DeviseHackFakeSession # この部分を追加します

end
