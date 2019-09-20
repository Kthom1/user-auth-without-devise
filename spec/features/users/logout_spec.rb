require "rails_helper"

RSpec.feature "Logout", :type => :feature do
  let(:user) { create(:user) }

  background do
    visit login_path
    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_on 'Submit'
  end

  scenario 'user successfully logs out', js: true do
    click_on 'Logout'
    expect(page).to have_content('Log in')
  end
end