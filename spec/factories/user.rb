FactoryBot.define do
  factory :user, class: User do
    skip_create
    id SecureRandom.uuid
    email Faker::Internet.free_email
    password Faker::Internet.password
  end
end
