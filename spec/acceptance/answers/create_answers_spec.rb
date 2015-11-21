require_relative '../acceptance_helper'

feature 'create answer' do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question, user: other_user) }

  scenario 'guest tries to answer question', js: true do
    visit question_path(question)
    expect(page).to_not have_selector(:link_or_button, 'Ответить')
  end

  scenario "user creates answer to your question", js: true  do
    sign_in(current_user)
    visit question_path(question)
    fill_in 'field_answer', with: "text text text"
    click_on "Ответить"
    within '#answers' do
      expect(page).to have_content "text text text"
    end
  end

  scenario "user create answer foregin question", js: true  do
    sign_in(current_user)
    visit question_path(other_question)
    fill_in 'field_answer', with: "text text text"
    click_on "Ответить"
    within '#answers' do
      expect(page).to have_content "text text text"
    end
  end

  scenario "user tries create answer with invalid data", js: true  do
    sign_in(current_user)
    visit question_path(question)
    click_on "Ответить"
    expect(page).to have_content "Content не может быть пустым"
  end

end
