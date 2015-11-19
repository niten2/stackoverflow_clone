require_relative '../acceptance_helper'

feature 'show answer' do

  given!(:current_user) { create(:user) }
  given!(:foregin_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'guest show answer', js: true do
    visit question_path(question)
    expect(page).to have_content answer.content
  end

  scenario 'owner user question show answer', js: true  do
    sign_in(current_user)
    visit question_path(question)
    expect(page).to have_content answer.content
  end

  scenario 'foregin user question show answer', js: true  do
    sign_in(foregin_user)
    visit question_path(question)
    expect(page).to have_content answer.content
  end

end

