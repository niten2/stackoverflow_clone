require_relative '../acceptance_helper'

feature 'Add files to answer' do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, user: user) }
  given!(:attachment) { create(:attachment, attachable: answer) }

  # scenario 'User adds file to answer', js: true do
  # scenario 'add file question', js: true do
  # scenario 'add several file question', js: true do
  # scenario 'add file question, and remove one file', js: true do
  # scenario 'owner question remove attachment file ofter create' do
  # scenario 'other user question tried remove attachment file ofter create' do
#     fill_in 'answer[content]', with: 'text text text'
#     attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
#     click_on 'Ответить'

#     within '#answers' do
#       expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
#     end
#   end
end
