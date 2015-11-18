require_relative '../acceptance_helper'

feature 'make_best answer' do

  given!(:current_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }

  given!(:answer) { create(:answer, question: question) }
  given!(:second_answer) { create(:answer, question: question) }
  given!(:thrid_answer) { create(:answer, question: question) }

  given!(:other_user) { create(:user) }
  given!(:other_question) { create(:question, user: other_user) }
  given!(:other_answer) { create(:answer, question: other_question) }

  given!(:answers) { create_list(:answer, 2, question: question) }

  scenario 'guest tries make_best answer' do
    visit question_path(question)
    expect(page).to have_content answer.content
    expect(page).to_not have_selector(:link_or_button, 'Выбрать лучший')
  end

  scenario 'not owner question tries make_best answer' do
    sign_in(other_user)
    visit question_path(question)
    expect(page).to have_content answer.content
    expect(page).to_not have_selector(:link_or_button, 'Выбрать лучший')
  end

  scenario 'owner question choose make_best answer', js: true do
    sign_in(current_user)
    visit question_path(question)
    expect(page).to have_content answer.content

    within "#answer_#{answer.id}" do
        click_on 'Выбрать лучший'
        expect(page).to have_content 'Лучший ответ'
      end
  end

  scenario 'owner question make_best answer and answer is first in list', js: true do
    sign_in(current_user)
    visit question_path(question)
    click_on "best-answer-link-#{answers.last.id}"

    within("#answer_#{answers.first.id}") do
      expect(page).to have_selector('.best-answer-link')
    end

    within("#answer_#{answers.last.id}") do
      expect(page).to_not have_selector('.best-answer-link')
    end
  end

end
