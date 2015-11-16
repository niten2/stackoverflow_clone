require_relative 'acceptance_helper'

feature 'User action answer' do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question, user: other_user) }
  given!(:answer) { create(:answer) }
  given!(:answer_params) { build(:answer, content: 'My answer') }

  scenario 'user create answer', js: true do
    sign_in(current_user)

    visit question_path(question)

    fill_in 'Содержание ответа', with: answer_params.content
    click_on 'Ответить'

    within '#answers' do
      expect(page).to have_content answer_params.content
    end
  end

  scenario "user trying invalid answer", js: true do
    sign_in(current_user)
    visit question_path(question)

    click_on 'Ответить'

    expect(page).to have_content "Content не может быть пустым"
  end


  # scenario 'user can write an answer to any question', js: true do
  #   sign_in(current_user)

  #   visit question_path(question)
  #   fill_in 'Содержание ответа', with: answer_params.content
  #   click_on "Ответить"
  #   expect(page).to have_content answer_params.content

  #   visit question_path(other_question)
  #   fill_in 'Содержание ответа', with: answer_params.content
  #   click_on "Ответить"
  #   expect(page).to have_content answer_params.content

  # end

  scenario 'user can view question and the answers thereto' do
    visit question_path(answer.question)

    expect(page).to have_content answer.question.title
    expect(page).to have_content answer.question.content
    expect(page).to have_content answer.content

  end

end
