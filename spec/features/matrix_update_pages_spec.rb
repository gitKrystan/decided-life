require 'rails_helper'

feature 'Editing a Matrix:' do
  given(:test_user) { create :confirmed_user }
  given!(:test_matrix) { create :matrix, owner: test_user }

  context 'Logged in as matrix owner:' do
    background do
      login_as(test_user)
    end

    scenario 'Edits a Matrix when all validated fields are entered' do
      visit matrix_path(test_matrix)
      click_on 'edit-matrix'
      click_link 'show-matrix-form'
      fill_in 'Name', with: 'Updated Matrix Name'
      click_button 'save-matrix'
      expect(page).to have_content('Updated Matrix Name')
    end

    scenario 'Returns an error when a validated field is not entered' do
      visit edit_matrix_path(test_matrix)
      click_link 'show-matrix-form'
      fill_in 'Name', with: ''
      click_button 'save-matrix'
      expect(page).to have_content('errors')
    end
  end

  context 'Logged in as someone else:' do
    background do
      login_as(create(:confirmed_user))
    end

    scenario 'Does not allow another user to edit the matrix' do
      visit edit_matrix_path(test_matrix)
      expect(page).to have_content('not authorized')
    end
  end
end
