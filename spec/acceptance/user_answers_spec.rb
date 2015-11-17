require_relative 'acceptance_helper'

feature 'User action answer' do

  given!(:current_user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }
  given!(:other_question) { create(:question, user: other_user) }
  given!(:answer) { create(:answer, question: question) }
  given!(:answer_two) { create(:answer, question: question) }
  given!(:answer_params) { build(:answer, content: 'My answer') }

  scenario 'user create answer', js: true do
    sign_in(current_user)

    visit question_path(question)

    fill_in 'field_answer', with: answer_params.content
    click_on 'Ответить'

    within '#answers' do
      expect(page).to have_content answer_params.content
    end
  end

  scenario 'sees link to Edit' do
    sign_in(current_user)

    visit question_path(question)

    within "#answer_#{answer.id}" do
      expect(page).to have_link "Редактировать"
    end
  end

  scenario 'user edit his answer', js: true do
    sign_in(current_user)
    visit question_path(question)

    within "#answer_#{answer.id}" do
      click_on 'Редактировать'
      fill_in 'Содержание ответа', with: 'edited answer'
      click_on 'Сохранить'

      expect(page).to_not have_content answer.content
      expect(page).to have_content 'edited answer'
      expect(page).to_not have_selector 'textarea'
    end
  end

  scenario 'user can write answer other_question', js: true do
    sign_in(current_user)

    visit question_path(other_question)
    fill_in 'field_answer', with: answer_params.content
    click_on "Ответить"
    expect(page).to have_content answer_params.content

  end

  scenario 'user can view question and answers' do
    sign_in(current_user)
    visit question_path(answer.question)

    expect(page).to have_content answer.question.title
    expect(page).to have_content answer.question.content
    expect(page).to have_content answer.content

  end

  scenario 'user delete your answer', js: true do
    sign_in(current_user)
    visit question_path(answer.question)

    within "#answer_#{answer.id}" do
      click_on "Удалить"
    end

    expect(page).to_not have_content answer.content
  end

  scenario "user can choose best answer and other best answer", js: true do
    sign_in(current_user)
    visit question_path(answer.question)

    within "#answer_#{answer.id}" do
      click_on "Выбрать лучший"
      expect(page).to have_content "Лучший ответ"
    end
  end

end
