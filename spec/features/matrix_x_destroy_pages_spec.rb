require 'rails_helper'

feature 'Destroying a Matrix:' do
  given!(:test_matrix) { create :matrix }

  scenario 'Destroys a matrix' do
    visit edit_matrix_path(test_matrix)
    click_link 'delete-matrix'
    expect(page).to have_content('successfully destroyed')
  end
end
