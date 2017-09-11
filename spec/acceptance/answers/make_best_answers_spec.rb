require_relative '../acceptance_helper'

feature 'make_best answer' do

  given!(:current_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }
  given!(:answer) { create(:answer, question: question) }
  given!(:other_answer) { create(:answer, question: question) }
  given!(:other_user) { create(:user) }

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

    within "#answer-#{answer.id}" do
        click_on 'Выбрать лучший'
        expect(page).to have_content 'Лучший ответ'
      end
  end

  scenario 'owner question make_best answer and answer is not link', js: true do
    sign_in(current_user)
    visit question_path(question)

    click_on "best-answer-link-#{answer.id}"
    expect(page).to_not have_selector("#best-answer-link-#{answer.id}")
    expect(page).to have_selector(".answer-content", text: answer.content)

    click_on "best-answer-link-#{other_answer.id}"
    expect(page).to_not have_selector("#best-answer-link-#{other_answer.id}")
    expect(page).to have_selector(".answer-content", text: other_answer.content)

    expect(page).to have_selector("#best-answer-link-#{answer.id}")

  end

  scenario "best answer seen first", js: true do
    sign_in(current_user)
    visit question_path(question)

    expect(answer.content).to have_content first(".answer-content").text
    expect(other_answer.content).to_not have_content first(".answer-content").text
    click_on "best-answer-link-#{other_answer.id}"
    sleep(2)
    expect(other_answer.content).to have_content first(".answer-content").text
    expect(answer.content).to_not have_content first(".answer-content").text

  end

end
