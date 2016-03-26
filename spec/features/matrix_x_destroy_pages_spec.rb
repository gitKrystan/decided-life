require 'rails_helper'

feature 'Destroying a Matrix:' do
  given(:test_user) { create :confirmed_user }
  given!(:test_matrix) { create :matrix, owner: test_user }

  background do
    login_as(test_user)
  end

  scenario 'Destroys a matrix' do
    visit edit_matrix_path(test_matrix)
    click_link 'delete-matrix'
    expect(page).to have_content('successfully deleted')
  end
end
