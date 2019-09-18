class User < ApplicationRecord
  has_secure_password
  validates :password, length: { minimum: 8 }
  validates :name, length: {minimum: 5}, on: :update
  validates :email, uniqueness: true, on: :create

  def self.return_username(email)
    email.split("@")[0]
  end

  def self.set_first_username(user_create_params)
    user = User.new(user_create_params)
    user.name = first_username = return_username(user_create_params[:email])
    return user
  end

end
