require "rails_helper"

RSpec.feature "Reset password", :type => :feature do
  let(:user) { create(:user) }

  background do
    clear_emails
    visit forgot_path
    within('form') do
      fill_in 'Email', with: user.email
    end
    click_on 'Reset Password'    
    open_email(user.email)
    current_email.click_link 'Reset Password!'
  end

  scenario 'user successfully resets password', js: true do
    within('form') do
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
    end
    click_on 'Update Password'
    expect(page).to have_content('You successfully updated your password.')
  end

  scenario 'user fails to reset password because password is too short', js: true do
    within('form') do
      fill_in 'Password', with: '1234567'
      fill_in 'Password confirmation', with: '1234567'
    end
    click_on 'Update Password'
    expect(page).to have_content('Password is too short (minimum is 8 characters)')
  end

  scenario 'user fails to reset password because password does not match password confirmation', js: true do
    within('form') do
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '123456789'
    end
    click_on 'Update Password'
    expect(page).to have_content('Password confirmation doesn\'t match Password')
  end
end