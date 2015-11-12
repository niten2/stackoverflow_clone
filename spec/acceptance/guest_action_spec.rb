require 'rails_helper'

feature 'Действия гостя', %q{
  Гость может просматривать вопросы и ответы
  но не может воздавать вопросы и отвечать на существующие вопросы
} do

  given!(:question) { create(:question) }

  scenario 'Гость пробует создать вопрос' do
    visit '/questions'
    click_on 'Создать вопрос'

    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться.'
  end

  scenario 'Гость пробует ответить на вопрос' do
    visit question_path(question)
    click_on 'Ответить'

    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться.'
  end

  scenario 'Гость может просматривать список вопросов' do
    visit questions_path

    expect(page).to have_content question.title
  end

end
