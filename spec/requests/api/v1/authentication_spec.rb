require 'rails_helper'

describe API::V1::AuthenticationController, type: :request do
  it_behaves_like "authenticatable"
end
