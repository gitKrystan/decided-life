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

  scenario 'Moves to Add Option step' do
    expect(page).to have_content('What are your options')
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
    click_link('skip this step')
  end

  scenario 'Adds new criteria when all validated fields are entered' do
    fill_in 'matrix_criteria_attributes_0_name', with: 'Test Criterium'
    click_button 'Continue'
    expect(page).to have_content('Your criteria have been updated.')
    expect(page).to have_content('Test Criterium')
  end

  scenario 'Adds additional criterium parameters if desired' do
    create :option, matrix: test_matrix
    fill_in 'matrix_criteria_attributes_0_name', with: 'Test Criterium'
    select '4', from: 'matrix_criteria_attributes_0_importance'
    fill_in 'matrix_criteria_attributes_0_bins_attributes_2_description',
            with: 'barely acceptable'
    click_button 'Continue'
    expect(page).to have_content('Test Criterium')
    expect(page).to have_content('2: barely acceptable')
    expect(page).to have_content('100')
  end

  scenario 'Does not create criteria when no criterium is added' do
    click_button 'Continue'
    expect(page).to have_content('No criteria have been added.')
  end

  scenario 'Returns an error when fields are incorrectly entered' do
    select '4', from: 'matrix_criteria_attributes_0_importance'
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
  end

  scenario 'Adds new options when all validated fields are entered' do
    fill_in 'matrix_options_attributes_0_name', with: 'Test Option'
    click_button 'Continue'
    expect(page).to have_content('Your options have been updated.')
    click_link('skip this step')
    expect(page).to have_content('Test Matrix')
    expect(page).to have_content('Test Option')
  end

  scenario 'Does not create options when no option is added' do
    click_button 'Continue'
    expect(page).to have_content('No options have been added.')
    click_link('skip this step')
    expect(page).to have_content('Test Matrix')
  end
end
