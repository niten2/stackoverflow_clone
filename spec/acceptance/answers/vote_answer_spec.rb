require_relative '../acceptance_helper'

feature 'vote answer' do

  given!(:owner_user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: owner_user) }
  given!(:answer) { create(:answer, question: question, user: owner_user) }

  scenario 'other_user upvote', js: true do
    sign_in(other_user)
    visit question_path(question)
    within "#answer-#{answer.id}" do
      click_on "За"
      expect(page).to have_content "Отменить"
    end
  end

  scenario 'other_user downvote', js: true  do
    sign_in(other_user)
    visit question_path(question)
    within "#answer-#{answer.id}" do
      click_on "Против"
      expect(page).to have_content "Отменить"
    end
  end

  scenario 'other_user upvote', js: true  do
    sign_in(other_user)
    visit question_path(question)
    within "#answer-#{answer.id}" do
      click_on "За"
      click_on "Отменить"
      expect(page).to have_content "За"
      expect(page).to have_content "Против"
    end
  end

  scenario 'owner user tried upvote, downvote, upvote' do
    sign_in(owner_user)
    visit question_path(question)
    within "#answer-#{answer.id}" do
      expect(page).to_not have_selector(:link_or_button, 'За')
      expect(page).to_not have_selector(:link_or_button, 'Против')
      expect(page).to_not have_selector(:link_or_button, 'Отменить')
    end
  end

end

