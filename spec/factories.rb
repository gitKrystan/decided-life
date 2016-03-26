FactoryGirl.define do
  factory :user, aliases: [:owner] do
    sequence :name do |n|
      "test-user-#{n}"
    end
    sequence :email do |n|
      "test-#{n}@example.com"
    end
    password 'f4k3p455w0rd'

    factory :confirmed_user do
      confirmed_at Time.zone.now
    end
  end

  factory :matrix do
    owner
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
