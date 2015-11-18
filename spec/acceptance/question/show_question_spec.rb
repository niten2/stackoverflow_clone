require_relative '../acceptance_helper'

feature 'show question' do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question, user: other_user) }

  scenario 'guest view questions' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.content
  end

  scenario 'user view your questions' do
    sign_in(current_user)
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.content
  end

  scenario 'user view foregin questions' do
    sign_in(current_user)
    visit question_path(other_question)
    expect(page).to have_content other_question.title
    expect(page).to have_content other_question.content
  end

end

