require 'rails_helper'

feature 'Destroying an Option:' do
  given(:test_user) { create :confirmed_user }
  given!(:test_matrix) { create :matrix, user: test_user }
  given!(:test_option) { create :option, matrix: test_matrix }

  background do
    login_as(test_user)
  end

  scenario 'Destroys a option' do
    visit edit_matrix_path(test_matrix)
    click_link "delete-option-#{test_option.id}"
    expect(page).to have_content('successfully deleted')
  end
end
