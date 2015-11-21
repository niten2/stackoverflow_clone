require_relative '../acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate my question
  As an question's author
  I'd like to be able to attach files
} do

  given!(:current_user) { create(:user) }

  background do
    sign_in(current_user)
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'question[title]', with: 'Test question'
    fill_in 'question[content]', with: 'text text text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Создать'

    expect(page).to have_content 'spec_helper.rb'
    # expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end
