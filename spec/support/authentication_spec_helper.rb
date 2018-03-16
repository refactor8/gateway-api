module AuthenticationSpecHelper
  class Request
    attr_reader :req

    def initialize(path, params, headers)
      params ||= {}
      headers ||= {}
      @req = OpenStruct.new(path: path, params: params, headers: headers)
    end

    def get
      authenticated_header!(req.headers)
      get req.path, params: req.params, headers: req.headers
    end

    def post
      authenticated_header!(req.headers)
      post req.path, params: req.params, headers: req.headers
    end

    def patch
      authenticated_header!(req.headers)
      patch req.path, params: req.params, headers: req.headers
    end

    def put
      authenticated_header!(req.headers)
      put req.path, params: req.params, headers: req.headers
    end

    def delete
      authenticated_header!(req.headers)
      delete req.path, params: req.params, headers: req.headers
    end
  end

  def jwt_token(user)
    token = JwtService.encode(
      payload: { sub: user.id }
    )
  end

  def json
    JSON.parse(response.body)
  end

  def user_token
    jwt_token(FactoryBot.build(:user))
  end

  def authenticated_header!(headers)
    headers.merge!('HTTP_AUTHORIZATION' => "Bearer #{user_token}")
  end

  def decode_jwt_token(token)
    token = JwtService.decode(token)
  end
end
