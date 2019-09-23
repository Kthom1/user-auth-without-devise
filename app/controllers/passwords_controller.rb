class PasswordsController < ApplicationController
  before_action :find_user_by_reset_password_token, only: [:update]
  before_action :find_user_by_email, only: [:create]
  
  def new
    
  end

  def create
    if params[:email].blank?
      redirect_to '/forgot', flash: { :messages => ["Please enter an email address."] }
    elsif @user.present?
      UserMailer.reset_password_email(@user).deliver_now
      redirect_to '/forgot', flash: { :messages => ["Nice, we'll send you an email with instructions."] }
    else
      redirect_to '/forgot',flash: { :messages => ["Can't find that email address."] }
    end
  end

  def edit
    @token = params[:token]
  end

  def update
    error_array = check_for_errors(params) 
    if error_array.empty? && @user.reset_password_token_valid?
      @user.reset_password(params[:password])
      redirect_to login_path, flash: { :messages => ["You successfully updated your password."] }
    else
      redirect_to reset_url(token: params[:token]), flash: { :messages => error_array }
    end
  end

  private

  def check_for_errors(params)
    error_array = []
    if params[:password].to_s.strip.length < 8 then error_array.push("Password is too short (minimum is 8 characters)") end
    if params[:password] != params[:password_confirmation] then error_array.push("Password confirmation doesn't match Password.") end
    return error_array
  end

  def find_user_by_reset_password_token
    @user = User.find_by(reset_password_token: params[:token])
  end

  def find_user_by_email
    @user = User.find_by(email: params[:email])
  end

end
