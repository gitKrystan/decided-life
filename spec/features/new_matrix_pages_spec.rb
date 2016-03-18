require 'rails_helper'

feature 'Creating a new Matrix:' do
  scenario 'Adding a new Matrix with all mandatory fields filled out' do
    visit matrices_path
    click_on 'new-matrix'
    fill_in 'Name', with: 'Test Matrix'
    click_button 'create-matrix'
    expect(page).to have_content('Test Matrix')
  end
end
