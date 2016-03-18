require 'rails_helper'

RSpec.describe Option, type: :model do
  it { should belong_to :matrix }
  it { should validate_presence_of :name }
end
