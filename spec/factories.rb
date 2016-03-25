FactoryGirl.define do
  factory :matrix do
    name 'Test Matrix'
  end

  factory :criterium do
    matrix
    name 'Test Criterium'
  end

  factory :option do
    matrix
    name 'Test Option'
  end
end
