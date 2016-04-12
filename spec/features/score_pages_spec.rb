require 'rails_helper'

feature 'Scoring a Matrix:' do
  given(:test_user) { create :confirmed_user }
  given(:test_matrix) { create :matrix, owner: test_user }
  given!(:test_criterium) { create :criterium, matrix: test_matrix }
  given!(:test_option) { create :option, matrix: test_matrix }
  given!(:test_select) { "score_amount_#{test_criterium.id}_#{test_option.id}" }
  given!(:test_selection) { test_criterium.bins.first }

  background do
    3.times { create :criterium, matrix: test_matrix }
    3.times { create :option, matrix: test_matrix }
    login_as(test_user)
  end

  scenario 'Adds a score to a criterium/option combination', js: true do
    visit edit_matrix_path(test_matrix)
    select test_selection.select_description, from: test_select
    expect(page).to have_select test_select,
                                selected: test_selection.select_description
    click_link('Presentation mode')
    expect(page).to have_content(test_selection.score)
  end

  scenario 'Adds a score to a criterium/option combination without js' do
    visit edit_matrix_path(test_matrix)
    select test_selection.select_description, from: test_select
    click_button "save_score_#{test_criterium.id}_#{test_option.id}"
    expect(page).to have_select test_select,
                                selected: test_selection.select_description
  end

  scenario 'Updates a score if it already exists without js' do
    test_score = create :score,
                        criterium: test_criterium,
                        option: test_option,
                        bin: test_criterium.bins.second
    visit edit_matrix_path(test_matrix)
    expect(page).to have_select test_select,
                                selected: test_score.bin.select_description
    select test_selection.select_description, from: test_select
    click_button "save_score_#{test_criterium.id}_#{test_option.id}"
    expect(page).to have_select test_select,
                                selected: test_selection.select_description
  end
end
