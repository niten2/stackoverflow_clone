require_relative '../acceptance_helper'

feature 'destroy answer' do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }

  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question, user: other_user) }

  given!(:answer) { create(:answer, question: question, user: current_user) }
  given!(:other_answer) { create(:answer, question: other_question) }
  given!(:other_answer_in_current_user_question) { create(:answer, question: question, user: other_user) }

  scenario 'guest tries delete answer', js: true do
    visit question_path(question)
    expect(page).to have_content answer.content
    expect(page).to_not have_selector(:link_or_button, 'Удалить')
  end

  scenario 'user delete your answer', js: true do
    sign_in(current_user)
    visit question_path(question)
    expect(page).to have_content answer.content
    within "#answer-#{answer.id}" do
      click_on "Удалить"
    end
    expect(page).to_not have_content answer.content
  end

  scenario 'user tries delete foreign answer in foregin question', js: true do
    sign_in(current_user)
    visit question_path(other_question)
    expect(page).to have_content other_answer.content
    expect(page).to_not have_selector(:link_or_button, 'Удалить')
  end

  scenario "owner question delete foregin answer", js: true do
    sign_in(current_user)
    visit question_path(question)
    expect(page).to have_content other_answer_in_current_user_question.content
    within "#answer-#{other_answer_in_current_user_question.id}" do
      click_on "Удалить"
    end
    expect(page).to_not have_content other_answer_in_current_user_question.content
  end
end
