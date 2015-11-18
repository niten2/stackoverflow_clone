require_relative '../acceptance_helper'

feature 'Siging out', %q{After registration, the user can exit the system} do

  given(:user) { create(:user) }

  scenario "existing user exits the account" do
    sign_in(user)
    visit root_path
    click_on 'Выйти'

    expect(page).to have_content 'Выход из системы выполнен.'
  end

end
