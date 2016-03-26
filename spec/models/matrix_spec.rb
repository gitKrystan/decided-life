require 'rails_helper'

RSpec.describe Matrix, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :user }
  it { should have_many(:criteria).dependent :destroy }
  it { should have_many(:options).dependent :destroy }
  it { should validate_presence_of :name }
end
