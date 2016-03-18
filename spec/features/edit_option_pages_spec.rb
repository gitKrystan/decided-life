require 'rails_helper'

feature 'Editing an Option:' do
  background do
    @test_matrix = Matrix.create(name: 'Test Matrix')
    @test_option = @test_matrix.options.create(name: 'Test Option')
  end

  scenario 'Edits an Option when all validated fields are entered' do
    visit matrix_path(@test_matrix)
    click_on "edit-option-#{@test_option.id}"
    fill_in 'Name', with: 'Updated Option Name'
    click_button 'save-option'
    expect(page).to have_content('Updated Option Name')
  end

  scenario 'Returns an error when a validated field is not entered' do
    visit edit_matrix_option_path(@test_matrix, @test_option)
    fill_in 'Name', with: ''
    click_button 'save-option'
    expect(page).to have_content('errors')
  end
end
