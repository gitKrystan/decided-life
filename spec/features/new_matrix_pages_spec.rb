require 'rails_helper'

feature 'Creating a new Matrix:' do
  scenario 'Adds a new Matrix when all validated fields are entered' do
    visit matrices_path
    click_on 'new-matrix'
    fill_in 'Name', with: 'Test Matrix'
    click_button 'create-matrix'
    expect(page).to have_content('Test Matrix')
  end

  scenario 'Returns an error when a validated field is not entered' do
    visit new_matrix_path
    click_button 'create-matrix'
    expect(page).to have_content('errors')
  end
end
