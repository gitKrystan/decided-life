require 'rails_helper'

RSpec.describe Score, type: :model do
  it { should belong_to :criterium }
  it { should belong_to :option }
  it { should belong_to :bin }
  it { should validate_presence_of :criterium }
  it { should validate_presence_of :option }
  it { should validate_presence_of :bin }
end
