class SessionsController < ApplicationController
  before_action :find_user_by_email, only: [:create]

  def new
  end

  def create
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/profile'
    else
      redirect_to '/login', flash: {:messages => ["Please try again."]}
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

  private

  def find_user_by_email
    @user = User.find_by(email: params[:email])
  end

end
