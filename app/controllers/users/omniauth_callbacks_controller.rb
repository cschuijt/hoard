class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    sign_in @user
    flash[:success] = "You are now logged in as @" + @user.username
    redirect_to root_url
  end

  def failure
    flash[:danger] = "Authentication through Twitter failed."
    redirect_to root_url
  end
end
