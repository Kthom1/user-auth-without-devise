class UsersController < ApplicationController
  before_action :authorize, only: [:show, :update]

  def show
    
  end

  def update
    cleaned_params = User.clean_update_params(user_update_params)
    if cleaned_params.key?(:valid_params) && @current_user.update(cleaned_params[:valid_params])
      redirect_to '/profile'
    elsif cleaned_params.key?(:error)
      @current_user.errors.add(:password, :too_short, message: cleaned_params[:error])
      redirect_to '/profile', flash: {:errors => @current_user.errors.full_messages}
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
      UserMailer.welcome_email(user).deliver_now
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
