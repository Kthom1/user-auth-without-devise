require "rails_helper"

context 'User model validations' do
  let(:user) { build(:user) }

  it 'creates succesfully' do 
    expect(user).to be_valid
  end

  it 'invalid because name shorter than 5 characters on update' do 
    user.update(name: 'a')
    expect(user).not_to be_valid
  end
end