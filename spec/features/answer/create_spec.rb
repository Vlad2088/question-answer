require 'rails_helper'

feature 'User can create answer', %q{
  In order to answer to question
  As an authenticated user
  I'd like to be able to create answer for specific question
}do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      
      visit question_path(question)
    end

    scenario 'Create answer with valid params' do
      fill_in 'Body', with: 'Answer text'
      click_on 'Answer'
    end

    scenario 'Create answer with invalid params' do
      fill_in 'Body', with: ''
      click_on 'Answer'

      expect(page).to have_content '1 error(s) detected:'
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'An unauthenticated user is trying to write a response'do
    visit question_path(question)

    expect(page).not_to have_selector(:link_or_button, 'Answer')
  end
end
