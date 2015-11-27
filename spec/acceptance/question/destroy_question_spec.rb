require_relative '../acceptance_helper'

feature 'destroy question' do

  given!(:current_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question) }

  scenario 'guest tries delete question' do
    visit question_path(question)
    expect(page).to_not have_content "Удалить вопрос"
  end

  scenario 'owner user delete question' do
    sign_in(current_user)
    visit question_path(question)
    click_on "Удалить"
    expect(page).to have_content "Вопрос удален"
  end

  scenario 'foregin user tries delete question' do
    sign_in(current_user)
    visit question_path(other_question)
    expect(page).to_not have_content "Удалить"
  end

end
