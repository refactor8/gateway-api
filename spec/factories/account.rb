FactoryBot.define do
  factory :account, class: Account do
    skip_create
    id SecureRandom.uuid
    subdomain { Faker::Internet.domain_word }
    user { create(:user) }
  end
end
