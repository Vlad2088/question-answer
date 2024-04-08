require 'rails_helper'

feature 'An authenticated user can remove a answer', %q{
  In order to remove the answer
  I'd like to be able to remove the snswer
}do
  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given!(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question, user: author) }

  scenario 'Authenticated user removes answer' do
    sign_in(author)
    visit question_path(question)
    click_on 'Remove answer'

    expect(page).to have_content 'Your answer has been deleted'
  end

  scenario 'An authenticated user is trying to delete someone else is response'do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_link 'Remove answer'
  end

  scenario 'Unauthenticated user removes answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Remove answer'
  end
end
