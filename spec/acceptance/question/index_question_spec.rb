require_relative '../acceptance_helper'

feature 'index question' do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:current_user_question) { create(:question, user: current_user) }
  given!(:other_user_question) { create(:question, user: other_user) }
  given!(:question) { create(:question) }

  scenario 'guest view list questions' do
    visit questions_path
    expect(page).to have_content current_user_question.title
    expect(page).to have_content other_user_question.title
    expect(page).to have_content question.title
  end

  scenario 'user view list your and foregin questions' do
    sign_in(current_user)
    visit questions_path
    expect(page).to have_content current_user_question.title
    expect(page).to have_content other_user_question.title
    expect(page).to have_content question.title
  end

end

