require_relative '../acceptance_helper'

feature 'make_best answer' do

  # given!(:current_user) { create(:user) }
  # given!(:other_user) { create(:user) }
  # given!(:question) { create(:question, user: current_user) }
  # given!(:other_question) { create(:question, user: other_user) }
  # given!(:answer) { create(:answer, question: question) }
  # given!(:answer_two) { create(:answer, question: question) }
  # given!(:answer_params) { build(:answer, content: 'My answer') }

  scenario 'guest tries make_best answer' do
    # sign_in(current_user)
    # visit question_path(other_question)
    # expect(page).to have_content other_answer.content
    # expect(page).to_not have_content "Удалить"
  end

  scenario 'owner question choose make_best answer and answer is first in list' do
    # sign_in(current_user)
    # visit question_path(other_question)
    # expect(page).to have_content other_answer.content
    # expect(page).to_not have_content "Удалить"
  end

  scenario 'owner question choose make_best other answer and answer is first in list' do
    # sign_in(current_user)
    # visit question_path(other_question)
    # expect(page).to have_content other_answer.content
    # expect(page).to_not have_content "Удалить"
  end

  scenario 'not owner question tries make_best answer' do
    # sign_in(current_user)
    # visit question_path(other_question)
    # expect(page).to have_content other_answer.content
    # expect(page).to_not have_content "Удалить"
  end

end
