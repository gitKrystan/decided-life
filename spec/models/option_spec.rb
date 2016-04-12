require 'rails_helper'

RSpec.describe Option, type: :model do
  it { should belong_to :matrix }
  it { should validate_presence_of :matrix }

  it { should have_many(:scores) }
  it { should have_many(:criteria).through(:scores) }
  it { should accept_nested_attributes_for :scores }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).scoped_to(:matrix_id) }

  describe '.criterium_score' do
    let(:test_matrix) { create :matrix }
    let!(:test_criterium) { create :criterium, matrix: test_matrix }
    let!(:test_option) { create :option, matrix: test_matrix }

    it 'returns zero if no score has been given' do
      expect(test_option.criterium_score(test_criterium)).to equal 0
    end

    it 'returns the score amount for the given criterium' do
      test_score = create :score,
                          criterium: test_criterium,
                          option: test_option,
                          bin: test_criterium.bins.first

      expect(test_option.criterium_score(test_criterium))
        .to equal test_score.amount
    end
  end

  describe '.weighted_criterium_score' do
    let(:test_matrix) { create :matrix }
    let!(:test_criterium) { create :criterium, matrix: test_matrix }
    let!(:test_option) { create :option, matrix: test_matrix }

    it 'returns zero if no score has been given' do
      expect(test_option.weighted_criterium_score(test_criterium)).to equal 0
    end

    it 'returns the weighted score amount for the given criterium' do
      test_score = create :score,
                          criterium: test_criterium,
                          option: test_option,
                          bin: test_criterium.bins.first

      expected_weighted_score = test_score.amount * test_criterium.weight
      expect(test_option.weighted_criterium_score(test_criterium))
        .to eq expected_weighted_score
    end
  end

  describe '.total_score' do
    let(:test_matrix) { create :matrix }
    let!(:criterium1) { create :criterium, matrix: test_matrix }
    let!(:criterium2) { create :criterium, matrix: test_matrix }
    let!(:test_option) { create :option, matrix: test_matrix }

    it 'returns zero if no scores have been given' do
      expect(test_option.total_score).to eq 0
    end

    it 'returns the total of all weighted scores for the option' do
      create :score, criterium: criterium1,
                     option: test_option,
                     bin: criterium1.bins.first
      create :score, criterium: criterium2,
                     option: test_option,
                     bin: criterium2.bins.last

      expected_total_score = test_option.weighted_criterium_score(criterium1) +
                             test_option.weighted_criterium_score(criterium2)
      expect(test_option.total_score).to eq expected_total_score
    end
  end
end
