require 'rails_helper'

describe 'the user authentication path' do
  it 'allows a user to sign in' do
    user = create(:confirmed_user)
    login_as(user)
    visit root_path
    expect(page).to have_content('Edit Profile')
  end
end
