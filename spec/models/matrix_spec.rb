require 'rails_helper'

RSpec.describe Matrix, type: :model do
  it { should belong_to :owner }
  it { should validate_presence_of :owner }

  it { should have_many(:criteria).dependent :destroy }
  it { should accept_nested_attributes_for(:criteria).allow_destroy(true) }
  it 'rejects attributes for a criterium if they are blank or default' do
    test_criterium_attributes = { name: '', importance: '3' }
    test_matrix = create :matrix
    test_matrix.update(criteria_attributes: [test_criterium_attributes])
    expect(test_matrix.criteria.count).to equal 0
  end

  it 'creates a criterium with valid attributes' do
    test_criterium_attributes = attributes_for :criterium
    test_matrix = create :matrix
    test_matrix.update(criteria_attributes: [test_criterium_attributes])
    expect(test_matrix.criteria.count).to equal 1
  end

  it { should have_many(:options).dependent :destroy }
  it { should accept_nested_attributes_for(:options).allow_destroy(true) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).scoped_to(:owner_id) }

  describe '.total_criteria_importance' do
    it 'sums the importance of the matrix criteria' do
      test_matrix = create :matrix
      create :criterium, matrix: test_matrix, importance: 1
      create :criterium, matrix: test_matrix, importance: 3
      create :criterium, matrix: test_matrix, importance: 4
      expect(test_matrix.total_criteria_importance).to equal 8
    end
  end

  describe '.options_by_score' do
    it 'returns the matrix options ordered by total score' do
      test_matrix = create :matrix
      test_criterium = create :criterium, matrix: test_matrix
      worst_option = create :option, matrix: test_matrix
      middle_option = create :option, matrix: test_matrix
      best_option = create :option, matrix: test_matrix
      create :score, criterium: test_criterium, option: best_option,
                     bin: test_criterium.bins.last
      create :score, criterium: test_criterium, option: middle_option,
                     bin: test_criterium.bins.second
      create :score, criterium: test_criterium, option: worst_option,
                     bin: test_criterium.bins.first
      expect(test_matrix.options_by_score)
        .to eq [best_option, middle_option, worst_option]
    end
  end

  describe '.winning_option' do
    it 'returns the option with the highest total score' do
      test_matrix = create :matrix
      test_criterium = create :criterium, matrix: test_matrix
      worst_option = create :option, matrix: test_matrix
      best_option = create :option, matrix: test_matrix
      create :score, criterium: test_criterium, option: best_option,
                     bin: test_criterium.bins.last
      create :score, criterium: test_criterium, option: worst_option,
                     bin: test_criterium.bins.first
      expect(test_matrix.winning_option).to eq best_option
    end
  end
end
