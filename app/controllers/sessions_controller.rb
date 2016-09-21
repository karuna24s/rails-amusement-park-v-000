class SessionsController < ApplicationController

  def new
  end

  def create
    if params[:user][:password].blank?
      redirect_to signin_path
    else
      user = User.find_by(name: params[:user][:name])
      user = user.try(:authenticate, params[:user][:password])
      return redirect_to root_path unless user
      session[:user_id] = user.id
      @user = user
      redirect_to user_path(@user)
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_url
  end

end
