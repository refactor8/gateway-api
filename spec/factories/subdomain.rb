FactoryBot.define do
  factory :subdomain, class: Hash do
    skip_create
    id SecureRandom.uuid
    subdomain { Faker::Internet.domain_word }
    user { create(:john) }
    initialize_with { attributes.stringify_keys }
  end
end
