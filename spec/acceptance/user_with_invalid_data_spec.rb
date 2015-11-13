require 'rails_helper'

feature 'User tries action' do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question, user: other_user) }
  given!(:other_answer) { create(:answer, question: other_question) }

  scenario 'user tries to delete a foreign question or answer' do
    sign_in(current_user)
    visit question_path(other_question)

    expect(page).to_not have_content "Удалить вопрос"

    expect(page).to have_content other_answer.content
    expect(page).to_not have_content "Удалить"

  end

  scenario "user tries to create an issue with invalid data" do
    sign_in(current_user)

    visit questions_path

    click_on "Создать вопрос"
    click_on "Создать"

    expect(page).to have_content "Произошли следующие ошибки"
  end

  scenario "user tries to create a response with an invalid data" do
    sign_in(current_user)

    visit question_path(question)

    click_on "Ответить"
    click_on "Ответить"

    expect(page).to have_content "Произошли следующие ошибки"
  end

end
