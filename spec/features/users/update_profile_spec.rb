require "rails_helper"

RSpec.feature "Update profile", :type => :feature do
  let(:user) { create(:user) }

  background do
    visit login_path
    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_on 'Submit'
  end

  scenario 'user successfully updates name', js: true do
    within('form') do
      fill_in 'Name', with: 'a' * 5
    end
    click_on 'Submit'
    expect(page).to have_content('Successfully updated!')
  end

  scenario 'user successfully updates password', js: true do
     within('form') do
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
    end
    click_on 'Submit'
    expect(page).to have_content('Successfully updated!')
  end

  scenario 'user fails to update anything because he leaves name and password fields blank', js: true do
    click_on 'Submit'
    expect(page).to have_content('Enter a new name or password to update your account')
  end

  scenario 'user fails update name because new name is two short', js: true do
    within('form') do
      fill_in 'Name', with: 'a' 
    end
    click_on 'Submit'
    expect(page).to have_content('Name is too short (minimum is 5 characters)')
  end

  scenario 'user fails update password because new password is too short', js: true do
    within('form') do
      fill_in 'Password', with: '1234567'
      fill_in 'Password confirmation', with: '1234567'
    end
    click_on 'Submit'
    expect(page).to have_content('Password is too short (minimum is 8 characters)')
  end

  scenario 'user fails update password because password does not match password confirmation', js: true do
    within('form') do
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '123456789'
    end
    click_on 'Submit'
    expect(page).to have_content('Password confirmation doesn\'t match Password')
  end
end