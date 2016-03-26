require 'rails_helper'

feature 'Destroying a Criterium:' do
  given(:test_user) { create :confirmed_user }
  given!(:test_matrix) { create :matrix, owner: test_user }
  given!(:test_criterium) { create :criterium, matrix: test_matrix }

  background do
    login_as(test_user)
  end

  scenario 'Destroys a criterium' do
    visit edit_matrix_path(test_matrix)
    click_link "delete-criterium-#{test_criterium.id}"
    expect(page).to have_content('successfully deleted')
  end
end
