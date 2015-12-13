require_relative '../acceptance_helper'

feature 'subscription' do

  given!(:current_user) { create(:user) }
  given!(:question) { create(:question, user: current_user) }

  scenario 'subscribe' do
    sign_in(current_user)
    visit question_path(question)
    click_on "Получать сообщение об ответах"
    expect(page).to_not have_selector(:link_or_button, "Получать сообщение об ответах")
  end

  scenario 'unsubscribe' do
    sign_in(current_user)
    visit question_path(question)
    click_on "Получать сообщение об ответах"
    click_on "Отписаться от получения сообщений об ответах"
    expect(page).to_not have_selector(:link_or_button, "Отписаться от получения сообщений об ответах")
  end

end

