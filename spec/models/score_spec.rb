require 'rails_helper'

RSpec.describe Score, type: :model do
  it { should belong_to :criterium }
  it { should belong_to :option }
end
