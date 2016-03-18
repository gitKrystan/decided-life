require 'rails_helper'

feature 'Editing a Matrix:' do
  given(:test_matrix) { Matrix.new(name: 'Test Matrix') }

  background do
    @test_matrix = Matrix.create(name: test_matrix.name)
  end

  scenario 'Edits a Matrix when all validated fields are entered' do
    visit matrix_path(@test_matrix)
    click_link 'edit-matrix'
    fill_in 'Name', with: 'Updated Matrix Name'
    click_button 'save-matrix'
    expect(page).to have_content('Updated Matrix Name')
  end
end
