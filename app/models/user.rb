class User < ApplicationRecord
  has_secure_password
  validates :password, length: { minimum: 8 }, on: :create
  validates :name, length: {minimum: 5}, on: :update
  validates :email, uniqueness: true, on: :create
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

  def self.return_username(email)
    email.split("@")[0]
  end

  def self.set_first_username(user_create_params)
    user = User.new(user_create_params)
    user.name = first_username = return_username(user_create_params[:email])
    return user
  end

  def self.clean_update_params(user_update_params)
    if user_update_params[:password].strip.empty?
      cleaned_params = user_update_params.except(:password, :password_confirmation)
      return {:valid_params => cleaned_params}
    elsif user_update_params[:password].length < 8
      return {:error => " is too short (minimum is 8 characters)"}
    else 
      return {:valid_params => user_update_params}
    end
  end

  def generate_reset_password_token
    self.update_attribute('reset_password_token', generate_token)
    self.update_attribute('reset_password_sent_at', Time.now.utc)
    return self.reset_password_token
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end

end
