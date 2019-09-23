require "rails_helper"

RSpec.feature "Conditional root routing", :type => :feature do
  let(:user) { create(:user) }

  scenario 'there is no current user so root_path is the sign up page (users#new)', js: true do
    visit root_path
    expect(page).to have_content('Sign Up')
  end

  scenario 'there is a current user so root_path routes to the profile page (users#edit)', js: true do
    visit login_path
    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_on 'Submit'
    visit root_path
    expect(page).to have_content('Profile')
  end
end