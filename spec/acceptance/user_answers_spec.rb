require 'rails_helper'

feature 'User action answer' do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question, user: other_user) }
  given!(:answer) { create(:answer) }

  scenario 'user can view question and the answers thereto' do
    visit question_path(answer.question)

    expect(page).to have_content answer.question.title
    expect(page).to have_content answer.question.content
    expect(page).to have_content answer.content

  end

  scenario 'user can write an answer to any question' do
    sign_in(current_user)

    visit question_path(question)
    click_on "Ответить"
    fill_in 'Ответ', with: 'answer'
    click_on "Ответить"
    expect(page).to have_content "Вы ответили"

    visit question_path(other_question)
    click_on "Ответить"
    fill_in 'Ответ', with: 'answer'
    click_on "Ответить"
    expect(page).to have_content "Вы ответили"

  end

end
