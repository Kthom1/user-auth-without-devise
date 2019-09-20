require "rails_helper"

RSpec.feature "Reset password mailer", :type => :feature do
  let(:user) { create(:user) }

  background do
    clear_emails
    visit forgot_path
    within('form') do
      fill_in 'Email', with: user.email
    end
    click_on 'Reset Password'    
    open_email(user.email)
  end

  scenario 'reset password email has the correct address', js: true do
    expect(current_email.to).to eq [user.email]
  end

  scenario 'reset password email has the correct content', js: true do
    expect(current_email).to have_content('Password Reset Instructions')
  end

  scenario 'user clicks reset password link in email and is successfully redirected to the reset password page', js: true do
    current_email.click_link 'Reset Password!'
    expect(page).to have_content 'Enter a new password'
  end
end