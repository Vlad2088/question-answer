require 'rails_helper'

feature 'User can view a list of questions', %q{
  To see all questions 
  as a visitor 
  I want to see a list of questions
}do
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3, user: user) }
  
  scenario 'All visitors can view questions' do
    visit questions_path
    expect(page).to have_content 'Questions:'

    questions.each do |question|
      expect(page).to have_content question.title
    end
  end
end
