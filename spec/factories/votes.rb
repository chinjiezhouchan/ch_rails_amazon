FactoryBot.define do
  factory :vote do
    vote { 1 }
    user { nil }
    review { nil }
  end
end
