require 'rails_helper'

feature 'An authenticated user can remove a question', %q{
  In order to remove the question
  I'd like to be able to remove the question
}do
  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given!(:question) { create(:question, user: author) }

  scenario 'Authenticated user removes question' do
    sign_in(author)
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    click_on 'Remove question'

    expect(page).to have_content 'Question removes'
  
    expect(page).to_not have_content question.title
    expect(page).to_not have_content question.body
  end

  scenario 'Authenticated user is trying to remove someone else is question'do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_link 'Remove question'
  end

  scenario 'Unauthenticated user removes question' do
    visit question_path(question)

    expect(page).to_not have_link 'Remove question'
  end
end
