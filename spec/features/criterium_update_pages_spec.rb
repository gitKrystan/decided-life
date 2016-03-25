require 'rails_helper'

feature 'Updating a Criterium:' do
  given!(:test_matrix) { create :matrix }
  given!(:test_criterium) { create :criterium, matrix: test_matrix }

  scenario 'Updates a Criterium when all validated fields are entered' do
    visit edit_matrix_path(test_matrix)
    click_on "edit-criterium-#{test_criterium.id}"
    fill_in 'Name', with: 'Updated Criterium Name'
    click_button 'save-criterium'
    expect(page).to have_content('Updated Criterium Name')
  end

  scenario 'Returns an error when a validated field is not entered' do
    visit edit_matrix_criterium_path(test_matrix, test_criterium)
    fill_in 'Name', with: ''
    click_button 'save-criterium'
    expect(page).to have_content('errors')
  end
end
