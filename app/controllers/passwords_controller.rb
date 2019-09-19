class PasswordsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by(email: params[:email])
    if params[:email].strip.empty?
      redirect_to '/forgot', flash: {:messages => ["Please enter an email address."]}
    elsif user.present?
      UserMailer.reset_password_email(user).deliver_now
      redirect_to '/forgot', flash: {:messages => ["Nice, we'll send you an email with instructions."]}
    else
      redirect_to '/forgot',flash: {:messages => ["Can't find that email address."]}
    end
  end

  def edit
    @token = params[:token]
  end

  def update
    error_array = check_for_errors(params) 
    if error_array.empty?
      user = User.find_by(reset_password_token: params[:token])
      user.reset_password(params[:password])
      redirect_to login_path, flash: {:messages => ["You successfully updated your password."]}
    else
      redirect_to reset_url(token: params[:token]), flash: {:messages => error_array}
    end
  end

  def check_for_errors(params)
    error_array = []
    if params[:password].strip.length < 8 then error_array.push("Password is too short (minimum is 8 characters)") end
    if params[:password] != params[:password_confirmation] then error_array.push("Password confirmation doesn't match Password.") end
    return error_array
  end

end
