require_relative '../acceptance_helper'

feature 'OAuth' do
  before { OmniAuth.config.test_mode = true }
  before {  visit root_path }

  describe 'Sign_in Twitter' do
    before { mock_auth_hash(:twitter) }

    scenario 'successfuly' do
      click_on 'Sign in with Twitter'
      expect(page).to have_content "Для завершения регистрации введите E-mail"
      fill_in "auth[info][email]", with: "test@mail.ru"
      click_on 'Ввести'
      expect(page).to have_content "Вход в систему выполнен с учётной записью из Finish_sign_up"
    end

    scenario 'with invalid credentials' do
      OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
      click_on 'Sign in with Twitter'
      expect(page).to have_content "Для завершения регистрации введите E-mail"
      fill_in "auth[info][email]", with: "test@mail.ru"
      click_on 'Ввести'
      expect(page).to have_content "Вход в систему выполнен с учётной записью из Finish_sign_up"
    end
  end

  describe 'facebook Sign in' do
    before { mock_auth_hash(:facebook) }

    it 'successfully' do
      click_on 'Sign in with Facebook'
      expect(page).to have_content 'Вход в систему выполнен с учётной записью из Facebook.'
    end

    it 'with invalid credentials' do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
      click_on 'Sign in with Facebook'
      expect(page).to have_content "Для завершения регистрации введите E-mail"
      fill_in "auth[info][email]", with: "test@mail.ru"
      click_on 'Ввести'
      expect(page).to have_content "Вход в систему выполнен с учётной записью из Finish_sign_up"
    end
  end

end
