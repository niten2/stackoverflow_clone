require_relative '../acceptance_helper'

feature 'destroy answer' do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question, user: other_user) }
  given!(:answer) { create(:answer, question: question) }
  given!(:other_answer) { create(:answer, question: other_question) }

  scenario 'guest tries delete answer', js: true do
    visit question_path(question)
    expect(page).to have_content answer.content
    expect(page).to_not have_selector(:link_or_button, 'Удалить')
  end

  scenario 'user delete your answer', js: true do
    sign_in(current_user)
    visit question_path(question)
    expect(page).to have_content answer.content
    click_on "Удалить"
    expect(page).to_not have_content answer.content
  end

  scenario 'user tries to delete a foreign answer', js: true do
    sign_in(current_user)
    visit question_path(other_question)
    expect(page).to have_content other_answer.content
    expect(page).to_not have_selector(:link_or_button, 'Удалить')
  end

end
