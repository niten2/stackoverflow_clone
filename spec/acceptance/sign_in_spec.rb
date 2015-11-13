require 'rails_helper'

feature 'Siging in', %q{In order to be able to ask questions, the user must log in} do

  given(:user) { create(:user) }

  scenario "existing User Account Login" do
    sign_in(user)
    expect(page).to have_content 'Вы успешно вошли.'
  end

  scenario 'non-existent user tries to log in to your account' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@user.com'
    fill_in 'Password', with: '12345'
    click_on 'Войти'

    expect(page).to have_content 'Неверный email или пароль.'
  end

end
