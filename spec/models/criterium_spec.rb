require 'rails_helper'

RSpec.describe Criterium, type: :model do
  it { should belong_to :matrix }
  it { should validate_presence_of :matrix }

  it { should have_many(:bins).dependent :destroy }

  it { should have_many(:scores).dependent :destroy }
  it { should have_many(:options).through(:scores) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).scoped_to(:matrix_id) }

  describe 'initialization callbacks' do
    it 'creates default bins' do
      criterium = build :criterium
      expect(criterium.bins.empty?).to be false
    end
  end

  describe '.weight' do
    it 'calculates the weight of a criterium based on importance in the matrix' do
      criterium1 = create :criterium, importance: 5
      criterium2 = create :criterium, importance: 3, matrix: criterium1.matrix
      criterium3 = create :criterium, importance: 2, matrix: criterium1.matrix
      expect(criterium1.weight).to eq 50
      expect(criterium2.weight).to eq 30
      expect(criterium3.weight).to eq 20
    end

    it 'calculates the weight of a criterium based on importance in the matrix' do
      criterium1 = create :criterium, importance: 5
      criterium2 = create :criterium, importance: 4, matrix: criterium1.matrix
      criterium3 = create :criterium, importance: 3, matrix: criterium1.matrix
      expect(criterium1.weight).to be_within(0.1).of(41.67)
      expect(criterium2.weight).to be_within(0.1).of(33.33)
      expect(criterium3.weight).to eq 25
    end
  end
end
