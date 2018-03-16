require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'is valid with a subdomain' do
    user = FactoryBot.create(:user, email: Faker::Internet.free_email, password: Faker::Internet.password)

    account = FactoryBot.create(:account, subdomain: Faker::Internet.domain_word, user: user)

    account.valid?
    expect(account).to be_valid
  end

  it 'is not valid without a subdomain' do
    account = Account.new(subdomain: nil)
    account.valid?
    expect(account).not_to be_valid
  end

  it 'belongs to an user' do
    t = Account.reflect_on_association(:user)
    expect(t.macro).to eq(:belongs_to)
  end
end
