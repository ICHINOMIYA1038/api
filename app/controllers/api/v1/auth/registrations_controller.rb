class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def create
    super do                                             # 他はdeviseの機能をそのまま流用する
      
    end
  end
  private
      def sign_up_params
        params.require(:registration).permit(:email, :password)
      end
  end