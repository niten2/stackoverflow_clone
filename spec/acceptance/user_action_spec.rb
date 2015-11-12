# require 'rails_helper'

# feature 'Create question', %q{
#   Действия пользователя:
#   Пользователь может создавать вопрос
#   Пользователь может просматривать список вопросов
#   Пользователь может написать ответ на вопрос
#   Пользователь может просматривать вопрос и ответы к нему.
#   Пользователь может удалить свой вопрос или ответ, но не может удалить чужой вопрос/ответ
# } do

#   given(:user1) { create(:user_with_question) }
#   given(:user2) { create(:user_with_question) }

#   scenario 'Пользователь создает вопрос' do
#     sign_in(user1)

#     visit '/questions'
#     click_on 'Ask question'
#     fill_in 'Title', with: 'Test question'
#     fill_in 'Content', with: 'text text text'
#     click_on 'Создать вопрос'

#     expect(page).to have_content 'Вы успешно создали вопрос.'
#   end

#   scenario 'Пользователь может просматривать список вопросов' do
#   end

#   scenario 'Пользователь может просматривать вопрос и ответы к нему' do
#   end

#   scenario 'Пользователь может написать ответ на любой вопрос' do
#   end

#   scenario 'Пользователь может удалить свой вопрос или ответ' do
#   end

#   scenario 'Пользователь пробует удалить чужой вопрос или ответ' do
#   end

# end
