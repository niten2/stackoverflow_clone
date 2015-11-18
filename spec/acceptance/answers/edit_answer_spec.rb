require_relative '../acceptance_helper'

feature 'destroy answer' do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question, user: other_user) }
  given!(:answer) { create(:answer, question: question) }
  given!(:other_answer) { create(:answer, question: other_question) }

  scenario 'guest tries edit answer' do
    visit question_path(question)
    expect(page).to have_content answer.content
    expect(page).to_not have_selector(:link_or_button, 'Редактировать')
  end

  scenario 'user edit your answer', js: true do
    sign_in(current_user)
    visit question_path(question)

    within "#answer_#{answer.id}" do
      expect(page).to have_content answer.content
      click_on 'Редактировать'
      fill_in 'Содержание ответа', with: 'edited answer'
      expect(page).to have_selector 'textarea'
      click_on 'Сохранить'
      expect(page).to_not have_content answer.content
      expect(page).to have_content 'edited answer'
      expect(page).to_not have_selector 'textarea'
    end
  end

  scenario 'user edit your answer with invalid data', js: true do
    sign_in(current_user)
    visit question_path(question)
    expect(page).to have_content answer.content
    click_on 'Редактировать'
    fill_in 'Содержание ответа', with: ''
    expect(page).to_not have_content "Content не может быть пустым"
  end

  scenario 'user tries edit foregin answer', js: true do
    sign_in(current_user)
    visit question_path(other_question)
    expect(page).to have_content other_answer.content
    expect(page).to_not have_selector(:link_or_button, 'Удалить')
  end

end
