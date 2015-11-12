require 'rails_helper'

feature 'Siging in', %q{
  Для того что бы можно было задавать
  вопросы пользователь должен войти в систему
 } do

  given(:user) { create(:user) }

  scenario "Существующий пользователь входит в учетную запись" do
    sign_in(user)
    expect(page).to have_content 'Вы успешно вошли.'
  end

  scenario 'Несуществующий пользователь пробует войти в учетную запись' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@user.com'
    fill_in 'Password', with: '12345'
    click_on 'Войти'

    expect(page).to have_content 'Неверный email или пароль.'
  end

end
