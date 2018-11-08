# We want to build objects as close to reality as possible, so in this case:
# No news article, when first created, has a view_count or published_at date.

FactoryBot.define do
  factory :news_article do

    association(:user, factory: :user)

    title { Faker::Book.title }
    description { Faker::Hipster.sentence(3,true,4) }

  end
end
