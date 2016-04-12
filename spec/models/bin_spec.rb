require 'rails_helper'

RSpec.describe Bin, type: :model do
  it { should belong_to :criterium }
  it { should have_many(:scores).dependent :destroy }
end
