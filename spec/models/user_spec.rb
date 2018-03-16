require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with an email and password" do
    user = User.new(email: Faker::Internet.free_email, password: Faker::Internet.password)
    user.valid?
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = User.new(email: nil, password: Faker::Internet.password)
    user.valid?
    expect(user.errors[:email]).to include(I18n.t('register_user_command.email'))
  end

  it "is not valid without a password" do
    user = User.new(email: Faker::Internet.free_email, password: nil)
    user.valid?
    expect(user.errors[:password]).to include(I18n.t('register_user_command.password'))
  end

  it "is an admin user when account is not present" do
    user = User.new(email: Faker::Internet.free_email, password: Faker::Internet.password)
    expect(user.accounts).to be_empty
    expect(user.role.to_sym).to eq :admin
  end

  it "is invalid with a duplicate email address" do
    email = Faker::Internet.free_email
    password = Faker::Internet.password

    user = User.create(email: email, password: password)
    user_copy = User.create(email: email, password: password)

    user_copy.valid?
    expect(user_copy.errors[:email]).to include(I18n.t('activerecord.errors.models.user.attributes.email.taken'))
  end
end
