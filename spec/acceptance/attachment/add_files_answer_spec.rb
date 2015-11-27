# require_relative '../acceptance_helper'

# feature 'Add files to answer' do

#   given(:user) { create(:user) }
#   given(:other_user) { create(:user) }

#   given(:question) { create(:question, user: user) }
#   given(:answer) { create(:answer, user: user, question: question) }
#   given!(:attachment) { create(:attachment, attachable: answer) }

#   given(:second_question) { create(:question, user: user) }

#   scenario 'user adds several file to answer', js: true do
#     sign_in(user)
#     visit question_path(question)
#     within '.new_answer' do
#       fill_in 'answer[content]', with: 'text text text'
#       click_on 'Добавить файл'
#       click_on 'Добавить файл'
#       inputs = all('input[type="file"]')
#       inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
#       inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
#       click_on 'Ответить'
#     end
#     within '#answers' do
#       expect(page).to have_link 'spec_helper.rb'
#       expect(page).to have_link 'rails_helper.rb'
#     end
#   end

#   scenario 'owner answer remove attachment file before create', js: true do
#     sign_in(user)
#     visit question_path(second_question)
#     within '.new_answer' do
#       fill_in 'answer[content]', with: 'text text text'
#       click_on 'Добавить файл'
#       click_on 'Добавить файл'
#       inputs = all('input[type="file"]')
#       inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
#       inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
#       click_on 'Удалить файл', match: :first
#       click_on 'Ответить'
#     end
#     within '#answers' do
#       expect(page).to_not have_link 'spec_helper.rb'
#       expect(page).to have_link 'rails_helper.rb'
#     end
#   end

#   scenario 'owner answer remove attachment file ofter create', js: true do
#     sign_in(user)
#     visit question_path(question)
#     within '#answers' do
#       click_on 'Удалить файл'
#       expect(page).to_not have_link 'spec_helper.rb'
#     end
#   end

#   scenario 'user adds several file to exist answer', js: true do
#     sign_in(user)
#     visit question_path(question)
#     within '#answers' do
#       click_on 'Редактировать'
#       click_on 'Добавить файл'
#       all('input[type="file"]')[0].set("#{Rails.root}/spec/spec_helper.rb")
#       click_on 'Сохранить'
#       expect(page).to have_link 'spec_helper.rb'
#     end
#   end

#   scenario 'other user answer tried remove attachment file ofter create' do
#     sign_in(other_user)
#     visit question_path(question)
#     within '#attachment' do
#       expect(page).to_not have_link 'Удалить файл'
#     end
#   end

# end
