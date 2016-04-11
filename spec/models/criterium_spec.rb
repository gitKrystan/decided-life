require 'rails_helper'

RSpec.describe Criterium, type: :model do
  it { should belong_to :matrix }
  it { should validate_presence_of :matrix }

  it { should have_many(:bins).dependent :destroy }

  it { should have_many(:scores) }
  it { should have_many(:options).through(:scores) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).scoped_to(:matrix_id) }
end
