require 'rails_helper'

feature 'Destroying a Criterium:' do
  given!(:test_criterium) { create :criterium }
  given!(:criterium_matrix) { test_criterium.matrix }

  scenario 'Destroys a criterium' do
    visit edit_matrix_path(criterium_matrix)
    click_link "delete-criterium-#{test_criterium.id}"
    expect(page).to have_content('successfully deleted')
  end
end
