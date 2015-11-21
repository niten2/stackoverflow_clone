require_relative '../acceptance_helper'

feature 'create question' do

  given!(:current_user) { create(:user) }

  scenario 'guest tries create question' do
    visit questions_path
    expect(page).to_not have_selector 'Создать вопрос'
  end

  scenario 'user create question' do
    sign_in(current_user)
    visit questions_path
    click_on 'Создать вопрос'
    fill_in 'Тема', with: 'Test question'
    fill_in 'Содержание', with: 'text text text'
    click_on 'Создать'
    expect(page).to have_content 'Вопрос создан'
  end

  scenario 'user create question invalid data' do
    sign_in(current_user)
    visit questions_path
    click_on 'Создать вопрос'
    click_on 'Создать'
    expect(page).to have_content "Произошли следующие ошибки"
  end

end
