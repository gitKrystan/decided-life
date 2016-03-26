require 'rails_helper'

feature 'the sign up path' do
  scenario 'allows a user to sign up' do
    new_user = build :user
    visit root_path
    click_link 'Sign Up'
    fill_in :user_name, with: new_user.name
    fill_in :user_email, with: new_user.email
    fill_in :user_password, with: new_user.password
    fill_in :user_password_confirmation, with: new_user.password
    click_button 'Sign up'
    expect(page).to have_content 'activate'
  end
end

feature 'the user authentication path' do
  scenario 'allows a user to sign in' do
    user = create :confirmed_user
    login_as(user)
    visit root_path
    expect(page).to have_content(user.name)
  end
end

feature 'validates user before managing records' do
  scenario 'does not allow someone who is not logged in to create a matrix' do
    visit new_matrix_path
    expect(page).to have_content('sign in or sign up before continuing')
  end
end
