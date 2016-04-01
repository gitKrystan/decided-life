require 'rails_helper'

RSpec.describe Matrix, type: :model do
  it { should belong_to :owner }
  it { should validate_presence_of :owner }

  it { should have_many(:criteria).dependent :destroy }
  it { should accept_nested_attributes_for(:criteria).allow_destroy(true) }
  it 'rejects attributes for a criterium if they are blank or default' do
    test_criterium_attributes = { name: '', weight: '100' }
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

  it { should have_many(:scores) }
  it { should accept_nested_attributes_for :scores }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).scoped_to(:owner_id) }
end
