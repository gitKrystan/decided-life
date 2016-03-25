require 'rails_helper'

feature 'Destroying an Option:' do
  given!(:test_option) { create :option }
  given!(:option_matrix) { test_option.matrix }

  scenario 'Destroys a option' do
    visit edit_matrix_path(option_matrix)
    click_link "delete-option-#{test_option.id}"
    expect(page).to have_content('successfully deleted')
  end
end
