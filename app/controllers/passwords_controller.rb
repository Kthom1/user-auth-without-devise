class PasswordsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by(email: params[:email])
    if params[:email].strip.empty?
      redirect_to '/forgot', flash: {:messages => ["Please enter an email address."]}
    elsif user.present?
      puts UserMailer.reset_password_email(user)
      redirect_to '/forgot', flash: {:messages => ["Nice, we'll send you an email with instructions."]}
    else
      redirect_to '/forgot',flash: {:messages => ["Can't find that email address."]}
    end
  end

  def edit
    @token = params[:token]
  end


  def update
    
  end

end
