require_relative '../acceptance_helper'

feature 'Add files to question' do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, user: user, question: question) }
  given!(:attachment) { create(:attachment, attachable: question) }
  given(:second_question) { create(:question, user: user) }


  scenario 'add several file in create question', js: true do
    sign_in(user)
    visit new_question_path
    fill_in 'question[title]', with: 'Test question'
    fill_in 'question[content]', with: 'text text text'
    click_on 'Добавить файл'
    click_on 'Добавить файл'
    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
    inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Создать'
    expect(page).to have_link 'spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb'
    # expect(page).to have_link 'spec_helper.rb', href: "/uploads/attachment/file/1/spec_helper.rb"
    # expect(page).to have_link 'rails_helper.rb', href: "/uploads/attachment/file/2/rails_helper.rb"
  end

  scenario 'edit file exist question', js: true do
    sign_in(user)
    visit question_path(second_question)
    click_on 'Редактировать вопрос'
    click_on 'Добавить файл'
    click_on 'Добавить файл'
    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
    inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Обновить'
    expect(page).to have_link 'spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb'
  end

  scenario 'add file question, and remove one file', js: true do
    sign_in(user)
    visit new_question_path
    fill_in 'question[title]', with: 'Test question'
    fill_in 'question[content]', with: 'text text text'
    click_on 'Добавить файл'
    click_on 'Добавить файл'
    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
    inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Удалить файл', match: :first
    click_on 'Создать'
    expect(page).to_not have_link 'spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb'
  end

  scenario 'owner question remove attachment file ofter create' do
    sign_in(user)
    visit question_path(question)
    click_on 'Удалить файл'
    expect(page).to_not have_link 'spec_helper.rb'
  end

  scenario 'other user question tried remove attachment file ofter create' do
    sign_in(other_user)
    visit question_path(question)
    expect(page).to_not have_link 'Удалить файл'
  end

end
