require 'rails_helper'

feature 'User action', %q{
   The user can create a question
   The user can view a list of questions
   The user can write an answer to the question
   The user can view the question and answer to it.
   You can delete your question or answer, but can not remove someone else's question / answer
} do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }

  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question, user: other_user) }

  given!(:answer) { create(:answer) }
  given!(:other_answer) { create(:answer, question: other_question) }

  scenario 'user creates a question' do
    sign_in(current_user)

    visit '/questions'
    click_on 'Создать вопрос'
    fill_in 'Тема', with: 'Test question'
    fill_in 'Содержание', with: 'text text text'
    click_on 'Создать'

    expect(page).to have_content 'Вопрос создан'
  end

  scenario 'user can view a list of questions' do
    visit questions_path

    expect(page).to have_content question.title
  end

  scenario 'user can view the question and the answers thereto' do
    visit question_path(answer.question)

    expect(page).to have_content answer.question.title
    expect(page).to have_content answer.question.content
    expect(page).to have_content answer.content

  end

  scenario 'user can write an answer to any question' do
    sign_in(current_user)

    visit question_path(question)
    click_on "Ответить"
    fill_in 'Ответ', with: 'answer'
    click_on "Ответить"
    expect(page).to have_content "Вы ответили"

    visit question_path(other_question)
    click_on "Ответить"
    fill_in 'Ответ', with: 'answer'
    click_on "Ответить"
    expect(page).to have_content "Вы ответили"

  end

  scenario 'user can delete your question or answer' do
    sign_in(current_user)
    visit question_path(question)

    click_on "Удалить вопрос"

    expect(page).to have_content "Вопрос удален"

  end

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
