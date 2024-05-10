require 'rails_helper'

feature 'Visitor can register in application', %q{
  In order to use appliation
  As an authenticated user
  I'd like to be able to register
}do
  background { visit new_user_registration_path }

  scenario 'A visitor tries to register with valid params' do
    fill_in 'Email',	with: 'user@test.com'
    fill_in 'Password',	with: '123456789'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'A visitor tries to register with invalid params' do
    fill_in 'Email',	with: 'user'
    fill_in 'Password',	with: '123456789'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Sign up'

    expect(page).to have_content '1 error prohibited this user from being saved:'
    expect(page).to have_content 'Email is invalid'
  end
end
