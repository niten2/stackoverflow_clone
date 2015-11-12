# require 'rails_helper'

# feature 'Действия гостя', %q{
#   Гость может просматривать вопросы и ответы
#   но не может воздавать вопросы и отвечать на существующие вопросы
# } do

#   scenario 'Гость пробует создать вопрос' do
#     visit '/questions'
#     click_on 'Создать вопрос'

#     expect(page).to have_content 'Сначала вам необходимо зарегестрироваться.'
#   end

#   scenario 'Гость пробует ответить на вопрос' do
#     visit '/questions/1'
#     click_on 'Создать вопрос'

#     expect(page).to have_content 'Сначала вам необходимо зарегестрироваться.'
#   end

#   scenario 'Гость может просматривать список вопросов' do
#   end

# end
