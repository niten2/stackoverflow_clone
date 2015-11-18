require_relative '../acceptance_helper'

feature 'edit question' do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question, user: other_user) }

  scenario 'guest tries edit questions' do
    visit question_path(question)
    expect(page).to_not have_content "Редактировать вопрос"
  end

  scenario 'owner user edit question' do
    sign_in(current_user)
    visit question_path(question)
    click_on "Редактировать вопрос"
    fill_in 'Тема', with: 'Test question'
    fill_in 'Содержание', with: 'text text text'
    click_on 'Обновить'
    expect(page).to have_content "Вопрос изменен"
  end

  scenario 'foregin user tries edit question' do
    sign_in(current_user)
    visit question_path(other_question)
    expect(page).to_not have_content "Редактировать вопрос"
  end

end
