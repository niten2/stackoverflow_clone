require_relative '../acceptance_helper'

feature 'destroy answer' do

  # given!(:current_user) { create(:user) }
  # given!(:other_user) { create(:user) }
  # given!(:question) { create(:question, user: current_user) }
  # given!(:other_question) { create(:question, user: other_user) }
  # given!(:answer) { create(:answer, question: question) }
  # given!(:answer_two) { create(:answer, question: question) }
  # given!(:answer_params) { build(:answer, content: 'My answer') }

  scenario 'guest tries delete answer' do
    sign_in(current_user)
    visit question_path(other_question)
    expect(page).to have_content other_answer.content
    expect(page).to_not have_content "Удалить"
  end

  scenario 'user delete your answer' do
    # sign_in(current_user)
    # visit question_path(other_question)
    # expect(page).to have_content other_answer.content
    # expect(page).to_not have_content "Удалить"
  end

  scenario 'user tries to delete a foreign answer' do
    # sign_in(current_user)
    # visit question_path(other_question)
    # expect(page).to have_content other_answer.content
    # expect(page).to_not have_content "Удалить"
  end

end
