require 'rails_helper'

describe Hash do
  describe '.clean_or_empty?' do
    it 'returns false if the attributes differ from the default attributes' do
      test_attributes = attributes_for(:criterium, weight: '99')
      expect(test_attributes.clean_or_empty?(:criterium)).to be false
    end

    it 'returns true if the attributes match the default attributes' do
      test_attributes = { name: '', weight: '100' }
      expect(test_attributes.clean_or_empty?(:criterium)).to be true
    end
  end
end
