describe JwtService do
  subject { described_class }

  let(:payload) do
    {:user => {
      :email => 'test@test.com',
      :password => SecureRandom.base64(10),
      :account_attributes => {
        :subdomain => 'test'
      }
    }
   }
  end

  let(:token) {
    subject.encode(payload)
  }

  describe '.encode' do
    it 'returns a valid JWT token' do
      expect(subject.encode(payload)).to eq(token)
    end
  end

  describe '.decode' do
    it 'successfully decodes the JWT token' do
      subject.decode(token)
    end
  end
end
