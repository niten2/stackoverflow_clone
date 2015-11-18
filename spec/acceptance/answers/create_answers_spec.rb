require_relative '../acceptance_helper'

feature 'create answer' do

  # given!(:current_user) { create(:user) }
  # given!(:other_user) { create(:user) }
  # given!(:question) { create(:question, user: current_user) }
  # given!(:other_question) { create(:question, user: other_user) }
  # given!(:answer) { create(:answer, question: question) }
  # given!(:answer_two) { create(:answer, question: question) }
  # given!(:answer_params) { build(:answer, content: 'My answer') }

  scenario 'guest tries to answer question' do
    visit question_path(question)
    click_on 'Ответить'
    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться.'
  end

  scenario "user creates answer to your question", js: true  do
    # sign_in(current_user)
    # visit question_path(question)
    # click_on "Ответить"
    # expect(page).to have_content "Content не может быть пустым"
  end

  scenario "user create answer foregin question", js: true  do
    # sign_in(current_user)
    # visit question_path(question)
    # click_on "Ответить"
    # expect(page).to have_content "Content не может быть пустым"
  end

  scenario "user tries create answer with invalid data", js: true  do
    # sign_in(current_user)
    # visit question_path(question)
    # click_on "Ответить"
    # expect(page).to have_content "Content не может быть пустым"
  end


end
