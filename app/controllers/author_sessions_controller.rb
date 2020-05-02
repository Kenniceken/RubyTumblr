class AuthorSessionsController < ApplicationController
  def new

  end

  def create
    if login(params[:email], params[:password])
      flash[:success] = "Welcome back! #{current_user.name}"
      redirect_back_or_to(posts_path)
    else
      flash.now[:warning] = "E-mail and/or Password is incorrect."
      render action: :new
    end
  end

  def destroy
      logout
      flash[:success] = "See You Soon (:"
      redirect_to login_path
  end
end
