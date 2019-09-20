require "rails_helper"

context 'User model validation' do
  let(:user) { build(:user) }

  it 'user is created successfully with proper parameters' do 
    expect(user).to be_valid
  end

  it 'update is valid because name has at least 5 characters' do 
    user.update(name: 'a' * 5)
    expect(user).to be_valid
  end

  it 'update is invalid because name shorter than 5 characters' do 
    user.update(name: 'a')
    expect(user).not_to be_valid
  end

  it 'update is valid because password has at least 8 characters' do 
    user.update(password: 'a' * 8, password_confirmation: 'a' * 8)
    expect(user).to be_valid
  end

   it 'update is invalid because password has fewer than 8 characters' do 
    user.update(password: 'a' * 7, password_confirmation: 'a' * 7)
    expect(user).not_to be_valid
  end
end