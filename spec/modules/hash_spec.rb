require 'rails_helper'

describe Hash do
  describe '.clean_or_empty?' do
    it 'returns false if the attributes differ from the default attributes' do
      test_attributes = attributes_for(:criterium, importance: '2')
      expect(test_attributes.clean_or_empty?(:criterium)).to be false
    end

    it 'returns true if the attributes match the default attributes' do
      test_attributes = { name: '', importance: '3' }
      expect(test_attributes.clean_or_empty?(:criterium)).to be true
    end
  end
end
