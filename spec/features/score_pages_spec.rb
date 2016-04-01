require 'rails_helper'

feature 'Scoring a Matrix:' do
  given(:test_user) { create :confirmed_user }
  given(:test_matrix) { create :matrix, owner: test_user }
  given!(:test_criterium) { create :criterium, matrix: test_matrix }
  given!(:test_option) { create :option, matrix: test_matrix }

  background do
    3.times { create :criterium, matrix: test_matrix }
    3.times { create :option, matrix: test_matrix }
    login_as(test_user)
  end

  scenario 'Adds a score to a criterium/option combination' do
    visit edit_matrix_path(test_matrix)
    fill_in "score_amount_#{test_criterium.id}_#{test_option.id}", with: '42'
    click_button "save_score_#{test_criterium.id}_#{test_option.id}"
    expect(page).to have_selector("input[value='42']")
  end

  scenario 'Updates a score if it already exists' do
    test_score = create :score, criterium: test_criterium, option: test_option
    visit edit_matrix_path(test_matrix)
    expect(page).to have_selector("input[value='#{test_score.amount}']")
    fill_in "score_amount_#{test_criterium.id}_#{test_option.id}", with: '42'
    click_button "save_score_#{test_criterium.id}_#{test_option.id}"
    expect(page).to have_selector("input[value='42']")
  end
end
