require "rails_helper"

RSpec.feature "Sign up", :type => :feature do

  scenario 'user navigates to the root path and successfully signs up', js: true do
    visit root_path 
    within('form') do
      fill_in 'Email', with: 'bob@bob.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
    end
    click_on 'Submit'
    expect(page).to have_content('Profile')
  end

  scenario 'user navigates to the root path and fails to sign up because his password is too short', js: true do
    visit root_path 
    within('form') do
      fill_in 'Email', with: 'bob@bob.com'
      fill_in 'Password', with: '1234567'
      fill_in 'Password confirmation', with: '1234567'
    end
    click_on 'Submit'
    expect(page).to have_content('Password is too short (minimum is 8 characters)')
  end

  scenario 'user navigates to the root path and fails to sign up because his email is invalid', js: true do
    visit root_path 
    within('form') do
      fill_in 'Email', with: 'bob'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
    end
    click_on 'Submit'
    expect(page).to have_content('Email is invalid')
  end

  scenario 'user navigates to the root path and fails to sign up because his password does not match his password confirmation', js: true do
    visit root_path 
    within('form') do
      fill_in 'Email', with: 'bob@email.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '123456789'
    end
    click_on 'Submit'
    expect(page).to have_content('Password confirmation doesn\'t match Password')
  end

end


