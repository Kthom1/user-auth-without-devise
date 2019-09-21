require "rails_helper"

RSpec.feature "Welcome new user mailer", :type => :feature do
  background do
    clear_emails
    visit root_path
    within('form') do
      fill_in 'Email', with: 'bob@bob.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
    end
    click_on 'Submit'
    open_email('bob@bob.com')
  end

  scenario 'welcome new user email has the correct address', js: true do
    expect(current_email.to).to eq ['bob@bob.com']
  end

  scenario 'welcome new user email has the correct content', js: true do
    expect(current_email).to have_content('You have successfully signed up with Incubit!')
  end
end