class UsersController < ApplicationController
  before_action :authorize, only: [:show, :edit]

  def show
    
  end

  def edit
    
  end

  def new
    
  end

  def create
    user = User.set_first_username(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/profile'
    else
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
