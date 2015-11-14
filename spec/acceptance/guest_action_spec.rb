require 'rails_helper'

feature 'Actions guests', %q{
  Guests can view the questions and answers but can not ask questions and respond to existing problems
  } do

  given!(:question) { create(:question) }
  given!(:second_question) { create(:question) }
  given!(:third_question) { create(:question) }

  scenario 'guest tries to ask the question' do
    visit '/questions'
    click_on 'Создать вопрос'

    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться.'
  end

  scenario 'guest tries to answer the question' do
    visit question_path(question)
    click_on 'Ответить'

    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться.'
  end

  scenario 'guests can view a list of questions' do
    visit questions_path

    expect(page).to have_content question.title
    expect(page).to have_content second_question.title
    expect(page).to have_content third_question.title
  end

end
