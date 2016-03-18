require 'rails_helper'

feature 'Viewing a Matrix:' do
  given(:test_matrix) { Matrix.new(name: 'Test Matrix') }

  background do
    Matrix.create(name: test_matrix.name)
  end

  scenario 'Shows all matrices on the root' do
    visit root_path
    expect(page).to have_content(test_matrix.name)
  end
end
