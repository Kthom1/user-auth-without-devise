require "rails_helper"

RSpec.feature "Login", :type => :feature do
  let(:user) { create(:user) }

  background do
    visit login_path
  end

  scenario 'existing user successfully logs in', js: true do
    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_on 'Submit'
    expect(page).to have_content('Profile')
  end

  scenario 'user fails to login because user account does not exist', js: true do
    within('form') do
      fill_in 'Email', with: 'bob@bob.com'
      fill_in 'Password', with: '12345678'
    end
    click_on 'Submit'
    expect(page).to have_content('Please try again.')
  end
end