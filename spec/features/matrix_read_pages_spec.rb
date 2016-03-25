require 'rails_helper'

feature 'Viewing a Matrix:' do
  given!(:test_matrix) { create :matrix }

  scenario 'Shows links to recent matrices on the root' do
    visit root_path
    click_link test_matrix.name
    expect(page).to have_content(test_matrix.name)
  end
end
