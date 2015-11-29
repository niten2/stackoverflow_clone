require_relative '../acceptance_helper'

feature 'Add comment question' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  given(:second_question) { create(:question, user: user) }
  given!(:second_comment) { create(:comment, commentable: second_question, user: user) }

  given(:third_question) { create(:question, user: user) }
  # given!(:third_comment) { create(:comment, commentable: third_question, user: user) }

  given(:other_user) { create(:user) }
  given!(:other_third_comment) { create(:comment, commentable: third_question, user: other_user) }




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
    visit question_path(second_question)
    within "#question_comment" do
      expect(page).to have_content second_comment.content
      click_on "Удалить"
      expect(page).to_not have_content second_comment.content
    end
  end

  it "owner question delete foregin comment" do
    sign_in(user)
    visit question_path(third_question)
    within "#question_comment" do
      expect(page).to have_content other_third_comment.content
      click_on "Удалить"
      expect(page).to_not have_content other_third_comment.content
    end
  end

  it "other user tried delete foregin comment" do
    sign_in(other_user)
    visit question_path(second_question)
    within "#question_comment" do
      expect(page).to have_content second_comment.content
      expect(page).to_not have_selector(:link_or_button, 'Удалить')
    end
  end

end
