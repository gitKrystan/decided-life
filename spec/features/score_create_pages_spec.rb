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
    expect(page).to have_content('42')
  end
end
