require_relative 'acceptance_helper'

feature 'create question' do

  # given!(:question) { create(:question) }
  # given!(:second_question) { create(:question) }
  # given!(:third_question) { create(:question) }

  scenario 'guest tries create question' do
    # visit '/questions'
    # click_on 'Создать вопрос'
    # expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться.'
  end

  scenario 'user create question' do
    # sign_in(current_user)
    # visit '/questions'
    # click_on 'Создать вопрос'
    # fill_in 'Тема', with: 'Test question'
    # fill_in 'Содержание', with: 'text text text'
    # click_on 'Создать'
    # expect(page).to have_content 'Вопрос создан'
  end

  scenario 'user create question invalid data' do
    # sign_in(current_user)
    # visit '/questions'
    # click_on 'Создать вопрос'
    # fill_in 'Тема', with: 'Test question'
    # fill_in 'Содержание', with: 'text text text'
    # click_on 'Создать'
    # expect(page).to have_content 'Вопрос создан'
  end

end
