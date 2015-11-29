require_relative '../acceptance_helper'

feature 'Add comment question' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  given(:other_question) { create(:question, user: user) }
  given!(:other_comment) { create(:comment, commentable: other_question, user: user) }

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

  it "show/hide form comment", js: true do
    sign_in(user)
    visit question_path(question)
    within "#question_comment" do
      expect(page).to_not have_selector :css, 'input[type="text"]'
      click_on "Добавить комментарий"
      expect(page).to have_selector :css, 'input[type="text"]'
      click_on  "Удалить комментарий"
      expect(page).to_not have_selector :css, 'input[type="text"]'
    end
  end

  it "delete comment" do
    sign_in(user)
    visit question_path(other_question)
    within "#question_comment" do
      expect(page).to have_content other_comment.content
      click_on "Удалить"
      expect(page).to_not have_content other_comment.content
    end
  end

end
