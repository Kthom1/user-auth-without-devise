class UsersController < ApplicationController
  before_action :authorize, only: [:edit, :update]

  def edit
    
  end

  def update
    if user_update_params[:name].blank? && user_update_params[:password].blank?
      redirect_to '/profile', flash: { :messages => ['Enter a new name or password to update your account'] }
    elsif @current_user.present? && @current_user.update(user_update_params)
      redirect_to '/profile', flash: { :messages => ['Successfully updated!'] }
    else
      redirect_to '/profile', flash: { :messages => @current_user.errors.full_messages }
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
      redirect_to '/signup', flash: { :messages => user.errors.full_messages }
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
