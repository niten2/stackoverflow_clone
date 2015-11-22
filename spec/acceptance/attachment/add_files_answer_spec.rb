require_relative '../acceptance_helper'

feature 'Add files to answer' do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, user: user) }
  given!(:attachment) { create(:attachment, attachable: answer) }

  scenario 'user adds several file to answer', js: true do
    sign_in(user)
    visit question_path(question)
    within '.new_answer' do
      fill_in 'answer[content]', with: 'text text text'
      click_on 'Добавить файл'
      click_on 'Добавить файл'
      inputs = all('input[type="file"]')
      inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
      inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
      click_on 'Ответить'
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb'
    end
  end


  scenario 'user adds several file to exist answer', js: true

  scenario 'owner answer remove attachment file', js: true
  scenario 'owner answer remove attachment file ofter create', js: true

  scenario 'other user anwer tried remove attachment file ofter create', js: true

end
