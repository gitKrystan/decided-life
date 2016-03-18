require 'rails_helper'

feature 'Editing a Criterium:' do
  background do
    @test_matrix = Matrix.create(name: 'Test Matrix')
    @test_criterium = @test_matrix.criteria.create(name: 'Test Criterium')
  end

  scenario 'Edits a Criterium when all validated fields are entered' do
    visit matrix_path(@test_matrix)
    click_on "edit-criterium-#{@test_criterium.id}"
    fill_in 'Name', with: 'Updated Criterium Name'
    click_button 'save-criterium'
    expect(page).to have_content('Updated Criterium Name')
  end

  scenario 'Returns an error when a validated field is not entered' do
    visit edit_matrix_criterium_path(@test_matrix, @test_criterium)
    fill_in 'Name', with: ''
    click_button 'save-criterium'
    expect(page).to have_content('errors')
  end
end
