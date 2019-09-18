class User < ApplicationRecord
  has_secure_password

  def self.return_username(email)
    email.split("@")[0]
  end

  def self.set_first_username(user_params)
    user = User.new(user_params)
    user.name = first_username = return_username(user_params[:email])
    return user
  end
end
