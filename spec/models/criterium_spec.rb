require 'rails_helper'

RSpec.describe Criterium, type: :model do
  it { should belong_to :matrix }
end
