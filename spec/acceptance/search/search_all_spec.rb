require_relative '../acceptance_helper'
require_relative '../sphinx_helper'

feature 'Search' do
  let!(:user) { create(:user, name: "test") }
  let!(:other_user) { create(:user, name: "name") }

  let!(:question) { create(:question, content: "test") }
  let!(:other_question) { create(:question) }

  let!(:answer) { create(:answer, content: "test") }
  let!(:other_answer) { create(:answer) }

  let!(:comment) { create(:comment, content: "test") }
  let!(:other_comment) { create(:comment) }

  scenario 'all', js: true do
    index
    visit find_path
    fill_in 'search_query[query]', with: "test"
    select('Искать везде', from: 'search_query_index_type')
    click_on 'Искать'

    expect(page).to have_content user.name
    expect(page).to have_content question.content
    expect(page).to have_content answer.content
    expect(page).to have_content answer.content

    expect(page).to_not have_content other_user.name
    expect(page).to_not have_content other_question.content
    expect(page).to_not have_content other_answer.content
    expect(page).to_not have_content other_comment.content
  end
end
