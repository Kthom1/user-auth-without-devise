require "rails_helper"

RSpec.feature "Reset password", :type => :feature do
  let(:user) { create(:user) }

  scenario 'user navigates to the forgot page and successfully gets a reset password email', js: true do
    user
    visit root_path 
    click_on 'Forgot Password'
    within('form') do
      fill_in 'Email', with: user.email
    end
    click_on 'Reset Password'
    expect(page).to have_content('Nice, we\'ll send you an email with instructions.')
  end
end