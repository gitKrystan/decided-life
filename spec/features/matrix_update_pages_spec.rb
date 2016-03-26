require 'rails_helper'

feature 'Editing a Matrix:' do
  given(:test_user) { create :confirmed_user }
  given!(:test_matrix) { create :matrix }

  background do
    login_as(test_user)
  end

  scenario 'Edits a Matrix when all validated fields are entered' do
    visit matrix_path(test_matrix)
    click_link 'edit-matrix'
    fill_in 'Name', with: 'Updated Matrix Name'
    click_button 'save-matrix'
    expect(page).to have_content('Updated Matrix Name')
  end

  scenario 'Returns an error when a validated field is not entered' do
    visit edit_matrix_path(test_matrix)
    fill_in 'Name', with: ''
    click_button 'save-matrix'
    expect(page).to have_content('errors')
  end
end
