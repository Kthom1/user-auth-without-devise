require "rails_helper"

RSpec.feature "Forgot password", :type => :feature do
  let(:user) { create(:user) }

  background do
    visit forgot_path 
  end

  scenario 'user successfully requests a reset password email', js: true do
    within('form') do
      fill_in 'Email', with: user.email
    end
    click_on 'Reset Password'
    expect(page).to have_content('Nice, we\'ll send you an email with instructions.')
  end

  scenario 'user fails to request a reset password email because the user\'s email is not registered', js: true do
    within('form') do
      fill_in 'Email', with: 'bob@bob.com'
    end
    click_on 'Reset Password'
    expect(page).to have_content('Can\'t find that email address.')
  end
end

