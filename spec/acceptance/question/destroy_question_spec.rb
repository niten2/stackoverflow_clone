require_relative 'acceptance_helper'

feature 'destroy question' do

  # given!(:question) { create(:question) }
  # given!(:second_question) { create(:question) }
  # given!(:third_question) { create(:question) }

  scenario 'guest tries delete  question' do
    # sign_in(current_user)
    # visit question_path(question)
    # click_on "Удалить вопрос"
    # expect(page).to have_content "Вопрос удален"
  end

  scenario 'owner user delete question' do
    # sign_in(current_user)
    # visit question_path(question)
    # click_on "Удалить вопрос"
    # expect(page).to have_content "Вопрос удален"
  end

  scenario 'foregin user tries delete question' do
    # sign_in(current_user)
    # visit question_path(other_question)
    # expect(page).to_not have_content "Удалить вопрос"
    # expect(page).to have_content other_answer.content
    # expect(page).to_not have_content "Удалить"
  end

end
