class UsersController < ApplicationController
  before_action :authorize, only: [:show, :update]

  def show
    
  end

  def update
    if @current_user.verify_name_length(user_update_params)
      redirect_to '/profile'
    else
      redirect_to '/profile', flash: {:errors => @current_user.errors.full_messages}
    end
  end

  def new
    
  end

  def create
    user = User.set_first_username(user_create_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/profile'
    else
      redirect_to '/signup', flash: {:errors => user.errors.full_messages}
    end
  end

  private

  def user_create_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

end
