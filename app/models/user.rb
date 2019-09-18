class User < ApplicationRecord
  has_secure_password

  def self.return_username(email)
    email.split("@")[0]
  end

  def self.set_first_username(user_create_params)
    user = User.new(user_create_params)
    user.name = first_username = return_username(user_create_params[:email])
    return user
  end

  def verify_name_length(user_update_params)
    if user_update_params[:name].length >= 5
      self.update(user_update_params)
    end
    return false
  end
  private 


end
