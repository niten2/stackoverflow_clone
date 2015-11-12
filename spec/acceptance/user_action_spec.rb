require 'rails_helper'

feature 'Create question', %q{
  Действия пользователя:
  Пользователь может создавать вопрос
  Пользователь может просматривать список вопросов
  Пользователь может написать ответ на вопрос
  Пользователь может просматривать вопрос и ответы к нему.
  Пользователь может удалить свой вопрос или ответ, но не может удалить чужой вопрос/ответ
} do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }

  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question, user: other_user) }

  given!(:answer) { create(:answer) }
  given!(:other_answer) { create(:answer, question: other_question) }

  scenario 'Пользователь создает вопрос' do
    sign_in(current_user)

    visit '/questions'
    click_on 'Создать вопрос'
    fill_in 'Тема', with: 'Test question'
    fill_in 'Содержание', with: 'text text text'
    click_on 'Создать'

    expect(page).to have_content 'Вопрос создан'
  end

  scenario 'Пользователь может просматривать список вопросов' do
    visit questions_path

    expect(page).to have_content question.title
  end

  scenario 'Пользователь может просматривать вопрос и ответы к нему' do
    visit question_path(answer.question)

    expect(page).to have_content answer.question.title
    expect(page).to have_content answer.question.content
    expect(page).to have_content answer.content

  end

  scenario 'Пользователь может написать ответ на любой вопрос' do
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

  scenario 'Пользователь может удалить свой вопрос или ответ' do
    sign_in(current_user)
    visit question_path(question)

    click_on "Удалить вопрос"

    expect(page).to have_content "Вопрос удален"

  end

  scenario 'Пользователь пробует удалить чужой вопрос или ответ' do
    sign_in(current_user)
    visit question_path(other_question)

    expect(page).to_not have_content "Удалить вопрос"

    expect(page).to have_content other_answer.content
    expect(page).to_not have_content "Удалить"

  end

end
