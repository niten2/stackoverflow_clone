require_relative '../acceptance_helper'

feature 'Add comment question' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  # given(:other_user) { create(:user) }
  # given(:answer) { create(:answer, user: user, question: question) }
  # given!(:attachment) { create(:attachment, attachable: question) }
  # given(:second_question) { create(:question, user: user) }


  it "create comment", js: true do
    sign_in(user)
    visit question_path(question)
    within "#question_comment" do
      click_on "Добавить комментарий"
      find(:css, 'input[type="text"]').set("comment question")
      click_on  "Создать комментарий"
      expect(page).to have_content 'comment question'
    end
  end

end
