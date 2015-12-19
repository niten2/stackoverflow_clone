require_relative '../acceptance_helper'
require_relative '../sphinx_helper'

feature 'Search' do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  scenario 'user', js: true do
    index
    visit find_path
    fill_in 'search_query[query]', with: user.email
    select('В пользователях', from: 'search_query_index_type')
    click_on 'Искать'

    expect(page).to have_content user.email
    expect(page).to_not have_content other_user.email
  end
end
