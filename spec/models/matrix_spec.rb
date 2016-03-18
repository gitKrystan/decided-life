require 'rails_helper'

RSpec.describe Matrix, type: :model do
  it { should have_many :criteria }
  it { should have_many :options }
  it { should validate_presence_of :name }
end
