require "rails_helper"

context 'User model validation' do
  let(:user) { create(:user) }

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

  it 'email update is not persisted because email is readonly' do 
    user.update(email: 'bob@bob.com')
    expect(user.reload.email).not_to eq('bob@bob.com')
  end

  it 'second user creation is invalid because its email address is not unique' do 
    user_two = build(:user, email: user.email)
    expect(user_two).not_to be_valid
  end
end