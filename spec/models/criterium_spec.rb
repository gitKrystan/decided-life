require 'rails_helper'

RSpec.describe Criterium, type: :model do
  it { should belong_to :matrix }
  it { should validate_presence_of :matrix }
  it { should validate_presence_of :name }
end
