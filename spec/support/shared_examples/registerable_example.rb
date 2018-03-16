RSpec.shared_examples "registerable" do
  context 'when account is valid' do
    let(:account) { FactoryBot.create(:subdomain) }

    before(:each) do
      post v1_register_url, params: { :account => account }
      @token = JSON.parse(response.body)["token"]
    end

    it 'returns a JWT token' do
      expect(@token).not_to be_nil
    end

    it 'returns a 200 code' do
      expect(response.status).to eq 200
    end

    it 'returns an empty error hash' do
      expect(JSON.parse(response.body)).not_to have_key(:errors)
    end
  end

  context 'when account is invalid' do
    let(:invalid_account) { FactoryBot.create(:subdomain, user: nil, subdomain: nil) }

    before(:each) do
      post v1_register_url, params: { :account => invalid_account }
      @errors = JSON.parse(response.body)["errors"]
      response.body
    end

    subject { @errors }

    it { is_expected.not_to be_nil }
    it { is_expected.to have_key("base") }
  end
end
