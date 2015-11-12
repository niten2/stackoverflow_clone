# require 'rails_helper'

# feature 'Siging out', %q{
#   После регистрации пользователь может выйти из системы
#  } do

#   given(:user) { create(:user) }

#   scenario "Существующий пользователь выходит из учетной записи" do
#     sign_in(user)
#     visit root_path
#     click_on 'Выйти'

#     expect(page).to have_content 'Вы успешно вошли.'
#   end

# end
