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
    sequence :name do |n|
      "Test Matrix #{n}"
    end
  end

  factory :criterium do
    matrix
    sequence :name do |n|
      "Test Criterium #{n}"
    end
  end

  factory :option do
    matrix
    sequence :name do |n|
      "Test Option #{n}"
    end
  end

  factory :score do
    criterium
    option
  end
end
