require 'rails_helper'

feature 'Creating a new Matrix:' do
  given(:test_user) { create :confirmed_user }

  background do
    login_as(test_user)
    visit matrices_path
    click_on 'new-matrix'
    fill_in 'Name', with: 'Test Matrix'
    click_button 'save-matrix'
  end

  scenario 'Adds a new Matrix when all validated fields are entered' do
    expect(page).to have_content('Test Matrix')
  end

  scenario 'Moves to Add Criteria step' do
    expect(page).to have_content('Add Criteria')
  end
end

feature 'Creating a new Matrix with errors:' do
  given(:test_user) { create :confirmed_user }

  scenario 'Returns an error when a validated field is not entered' do
    login_as(test_user)
    visit new_matrix_path
    click_button 'save-matrix'
    expect(page).to have_content('errors')
  end
end

feature 'Adding criteria: ' do
  given(:test_user) { create :confirmed_user }
  given!(:test_matrix) { create :matrix, owner: test_user }

  background do
    login_as(test_user)
    visit matrix_steps_path(test_matrix)
  end

  scenario 'Adds new criteria when all validated fields are entered' do
    fill_in 'matrix_criteria_attributes_0_name', with: 'Test Criterium'
    click_button 'Continue'
    expect(page).to have_content('Your criteria have been updated.')
    expect(page).to have_content('Add Options')
    click_link('skip this step')
    expect(page).to have_content('Test Criterium')
  end

  scenario 'Does not create criteria when no criterium is added' do
    click_button 'Continue'
    expect(page).to have_content('No criteria have been added.')
    expect(page).to have_content('Add Options')
  end

  scenario 'Returns an error when fields are incorrectly entered' do
    fill_in 'matrix_criteria_attributes_0_importance', with: '42'
    click_button 'Continue'
    expect(page).to have_content('errors')
  end
end

feature 'Adding options: ' do
  given(:test_user) { create :confirmed_user }
  given!(:test_matrix) { create :matrix, owner: test_user }

  background do
    login_as(test_user)
    visit matrix_steps_path(test_matrix)
    click_link('skip this step')
  end

  scenario 'Adds new options when all validated fields are entered' do
    fill_in 'matrix_options_attributes_0_name', with: 'Test Option'
    click_button 'Continue'
    expect(page).to have_content('Your options have been updated.')
    expect(page).to have_content('Test Matrix')
    expect(page).to have_content('Test Option')
  end

  scenario 'Does not create options when no option is added' do
    click_button 'Continue'
    expect(page).to have_content('No options have been added.')
    expect(page).to have_content('Test Matrix')
  end
end
