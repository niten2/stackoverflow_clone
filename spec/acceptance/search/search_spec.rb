require_relative '../acceptance_helper'

feature 'search' do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, user: user) }
  let!(:comment) { create(:comment, user: user) }

  scenario 'find user', js: true do
    sign_in(user)
    visit find_path
    # binding.pry
    fill_in "search_query[query]", with: question.title
    find("#search_query_index_type").find(:xpath, 'option[3]').select_option
    save_and_open_page
    click_on "Искать"

    expect(page.body).to eq question.title
  end

  scenario 'find question' do
    # sign_in(other_user)
    # visit question_path(question)
    # click_on "За"
    # expect(page).to have_content "Отменить"
  end

  scenario 'find answer' do
  end

  scenario 'find comment' do
  end

end

