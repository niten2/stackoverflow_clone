require_relative '../acceptance_helper'
require_relative '../sphinx_helper'

feature 'Search' do
  let!(:comment) { create(:comment) }
  let!(:other_comment) { create(:comment) }

  scenario 'comment', js: true do
    index
    visit find_path
    fill_in 'search_query[query]', with: comment.content
    # select('В комментариях', from: 'search_query_index_type')
    select('Comment', from: 'search_query_index_type')
    click_on 'Искать'

    expect(page).to have_content comment.content
    expect(page).to_not have_content other_comment.content
  end
end
