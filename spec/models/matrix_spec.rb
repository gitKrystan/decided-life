require 'rails_helper'

RSpec.describe Matrix, type: :model do
  it { should belong_to :owner }
  it { should validate_presence_of :owner }
  it { should have_many(:criteria).dependent :destroy }
  it { should have_many(:options).dependent :destroy }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).scoped_to(:owner_id) }
end
