require_relative 'acceptance_helper'

feature 'show question' do

  # given!(:current_user) { create(:user) }
  # given!(:other_user) { create(:user) }
  # given!(:question) { create(:question, user: current_user) }
  # given!(:other_question) { create(:question, user: other_user) }

  scenario 'guest view questions' do
    #   visit questions_path
    #   expect(page).to have_content question.title
    #   expect(page).to have_content second_question.title
    #   expect(page).to have_content third_question.title
  end

  scenario 'user view your questions' do
    # visit questions_path
    # expect(page).to have_content question.title
    # expect(page).to have_content other_question.title
  end

  scenario 'user view foregin questions' do
    # visit questions_path
    # expect(page).to have_content question.title
    # expect(page).to have_content other_question.title
  end

end

