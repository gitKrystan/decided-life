require 'rails_helper'

feature 'Viewing a Matrix:' do
  given!(:test_owner) { create :confirmed_user }
  given!(:test_matrix) { create :matrix, owner: test_owner }
  given!(:somebody_else) { create :confirmed_user }

  scenario 'User is not logged in' do
    visit root_path
    click_link test_matrix.name
    expect(page).to have_content(test_matrix.name)
    expect(page).to have_content('Log in to edit')
    expect(current_path).to eq matrix_path(test_matrix)
  end

  scenario 'User is logged in as someone other than the owner' do
    login_as(somebody_else)
    visit root_path
    click_link test_matrix.name
    expect(page).to have_content(test_matrix.name)
    expect(page).to have_content('Log in to edit')
    expect(current_path).to eq matrix_path(test_matrix)
  end

  scenario 'User is logged in as the owner' do
    login_as(test_owner)
    visit root_path
    click_link test_matrix.name
    expect(page).to have_content(test_matrix.name)
    expect(current_path).to eq edit_matrix_path(test_matrix)
  end
end
