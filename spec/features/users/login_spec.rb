require "rails_helper"

RSpec.feature "Login", :type => :feature do
  let(:user) { create(:user) }

  scenario 'user navigates to the login page and successfully logs in', js: true do
    user
    visit root_path 
    click_on 'Login'
    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_on 'Submit'
    expect(page).to have_content('Profile')
  end

  scenario 'user navigates to the login page and fails to login because user account does not exist', js: true do
    user
    visit root_path 
    click_on 'Login'
    within('form') do
      fill_in 'Email', with: 'bob@bob.com'
      fill_in 'Password', with: '12345678'
    end
    click_on 'Submit'
    expect(page).to have_content('Please try again.')
  end

end