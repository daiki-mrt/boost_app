class Users::SessionsController < Devise::SessionsController
  # ゲストユーザーでログインする
  def new_guest
    user = User.guest
    sign_in user
    redirect_to root_path, notice: ""
  end  
end