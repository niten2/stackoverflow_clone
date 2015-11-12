require 'rails_helper'

feature 'Регистрация пользователя', %q{
  Для того что бы войти в систему
  пользователь должен зарегестрироваться
 } do

  scenario 'Несуществующий пользователь регистрируется' do
    visit new_user_registration_path
    fill_in 'Email', with: 'wrong@user.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Зарегестрироваться'

    expect(page).to have_content 'Добро пожаловать! Вы успешно зарегистрировались.'
  end

  scenario 'Несуществующий пользователь пробует зарегестрироваться' do
    visit new_user_registration_path
    click_on 'Зарегестрироваться'

    expect(page).to have_content 'сохранение не удалось'
  end

end
