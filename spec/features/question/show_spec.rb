require 'rails_helper'

feature 'Visitors can view a specific question and answers', %q{
  To see a specific question and answers
  as a visitor 
  I want to see a specific question and answers
}do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'All visitors can view a specific question and answers' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    expect(page).to have_content 'Answers:'
    expect(page).to have_content answer.body
  end
end
