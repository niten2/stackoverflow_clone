require_relative '../acceptance_helper'
require_relative '../sphinx_helper'

feature 'Search' do
  let!(:answer) { create(:answer) }
  let!(:other_answer) { create(:answer) }

  scenario 'answer', js: true do
    index
    visit find_path
    fill_in 'search_query[query]', with: answer.content
    select('В комментариях', from: 'search_query_index_type')
    click_on 'Искать'

    expect(page).to have_content answer.content
    expect(page).to_not have_content other_answer.content
  end
end
