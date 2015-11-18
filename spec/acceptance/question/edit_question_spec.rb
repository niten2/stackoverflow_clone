require_relative 'acceptance_helper'

feature 'edit question' do

  # given!(:current_user) { create(:user) }
  # given!(:other_user) { create(:user) }
  # given!(:question) { create(:question, user: current_user) }
  # given!(:other_question) { create(:question, user: other_user) }

  scenario 'guest tries edit questions' do
    # visit questions_path
    # expect(page).to have_content question.title
    # expect(page).to have_content other_question.title
  end

  scenario 'owner user edit question' do
    # sign_in(current_user)
    # visit '/questions'
    # click_on 'Создать вопрос'
    # fill_in 'Тема', with: 'Test question'
    # fill_in 'Содержание', with: 'text text text'
    # click_on 'Создать'
    # expect(page).to have_content 'Вопрос создан'
  end

  scenario 'foregin user tries edit question' do
    # sign_in(current_user)
    # visit question_path(question)
    # click_on "Удалить вопрос"
    # expect(page).to have_content "Вопрос удален"
  end

end
