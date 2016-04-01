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
                          option: test_option

      expect(test_option.criterium_score(test_criterium))
        .to equal test_score.amount
    end
  end
end
