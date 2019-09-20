require "rails_helper"

RSpec.feature "Sign up", :type => :feature do
  background do
    visit root_path 
  end

  scenario 'user successfully signs up', js: true do
    within('form') do
      fill_in 'Email', with: 'bob@bob.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
    end
    click_on 'Submit'
    expect(page).to have_content('Profile')
  end

  scenario 'user fails to sign up because his password is too short', js: true do
    within('form') do
      fill_in 'Email', with: 'bob@bob.com'
      fill_in 'Password', with: '1234567'
      fill_in 'Password confirmation', with: '1234567'
    end
    click_on 'Submit'
    expect(page).to have_content('Password is too short (minimum is 8 characters)')
  end

  scenario 'user fails to sign up because his email is invalid', js: true do
    within('form') do
      fill_in 'Email', with: 'bob'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
    end
    click_on 'Submit'
    expect(page).to have_content('Email is invalid')
  end

  scenario 'user fails to sign up because his password does not match his password confirmation', js: true do
    within('form') do
      fill_in 'Email', with: 'bob@email.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '123456789'
    end
    click_on 'Submit'
    expect(page).to have_content('Password confirmation doesn\'t match Password')
  end
end


