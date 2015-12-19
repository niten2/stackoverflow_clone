require_relative '../acceptance_helper'
require_relative '../sphinx_helper'

feature 'Search question' do
  let!(:question) { create(:question) }
  let!(:other_question) { create(:question) }

  scenario 'title', js: true do
    index
    visit find_path
    fill_in 'search_query[query]', with: question.title
    # select('В вопросах', from: 'search_query_index_type')
    select('Question', from: 'search_query_index_type')
    click_on 'Искать'

    expect(page).to have_content question.title
    expect(page).to_not have_content other_question.title
  end

  scenario 'content', js: true do
    index
    visit find_path
    fill_in 'search_query[query]', with: question.content
    # select('В вопросах', from: 'search_query_index_type')
    select('Question', from: 'search_query_index_type')
    click_on 'Искать'

    expect(page).to have_content question.content
    expect(page).to_not have_content other_question.content
  end

end
