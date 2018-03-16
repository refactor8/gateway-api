FactoryBot.define do
  factory :john, class: Hash do
    skip_create
    id SecureRandom.uuid
    email Faker::Internet.free_email
    password Faker::Internet.password
    initialize_with { attributes.stringify_keys }
  end
end
