# require 'rails_helper'

# feature 'Регистрация пользователя', %q{
#   Для того что бы войти в систему
#   пользователь должен зарегестрироваться
#  } do

#   scenario 'Несуществующий пользователь регистрируется' do
#     # visit
#     fill_in 'Email', with: 'wrong@user.com'
#     fill_in 'Password', with: '12345678'
#     click_on 'Зарегестрироваться'

#     expect(page).to have_content 'Вы успешно вошли.'
#   end

#   scenario 'Несуществующий пользователь пробует зарегестрироваться' do
#     # visit
#     click_on 'Зарегестрироваться'

#     # expect(page).to have_content ''
#   end

# end
