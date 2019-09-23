class User < ApplicationRecord
  has_secure_password
  validates :password, length: { minimum: 8 }, on: :create
  validates :password, length: { minimum: 8 }, on: :update, allow_blank: true
  validates :name, length: { minimum: 5 }, on: :update, unless: :name_not_changed
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  attr_readonly :email
  before_validation :set_name_to_previous_if_blank

  def self.set_first_username(user_create_params)
    user = User.new(user_create_params)
    user.name = first_username = return_username(user_create_params[:email])
    return user
  end

  def generate_reset_password_token
    self.update_attribute('reset_password_token', generate_token)
    self.update_attribute('reset_password_sent_at', Time.now.utc)
    return self.reset_password_token
  end

  def reset_password(password)
    self.update_attribute('password', password) 
    self.update_attribute('reset_password_token', nil)
    self.update_attribute('reset_password_sent_at', nil)  
  end

  def reset_password_token_valid?
    (self.reset_password_sent_at + 6.hours) > Time.now.utc
  end

  private

  def self.return_username(email)
    email.split("@")[0]
  end

  def name_not_changed
    self.name == self.name_was
  end

  def set_name_to_previous_if_blank 
    if name.blank? 
      self.name = self.name_was
    end
  end

  def generate_token
    SecureRandom.hex(10)
  end
end
