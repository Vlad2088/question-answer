require 'rails_helper'

feature 'User can sign out', %q{
  In order to exit from application
  I'd like to be able to sign out
}do

  given!(:user) { create(:user) }

  background { visit root_path }

  scenario 'User logs out' do
    sign_in(user)
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.' 
  end
end
