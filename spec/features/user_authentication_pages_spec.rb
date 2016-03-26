require 'rails_helper'

describe 'the sign up path' do
  it 'allows a user to sign up' do
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

describe 'the user authentication path' do
  it 'allows a user to sign in' do
    user = create :confirmed_user
    login_as(user)
    visit root_path
    expect(page).to have_content(user.name)
  end
end
