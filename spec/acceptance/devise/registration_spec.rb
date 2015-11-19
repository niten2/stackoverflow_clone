require_relative '../acceptance_helper'

feature 'User registration' do

  scenario 'non-existent user logs' do
    visit new_user_registration_path
    fill_in 'Email', with: 'wrong@user.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Зарегестрироваться'

    expect(page).to have_content 'Добро пожаловать! Вы успешно зарегистрировались.'
  end

  scenario 'user tries to create a non-existent' do
    visit new_user_registration_path
    click_on 'Зарегестрироваться'

    expect(page).to have_content 'сохранение не удалось'
  end

end
