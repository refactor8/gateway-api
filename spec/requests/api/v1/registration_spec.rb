require 'rails_helper'

describe API::V1::RegistrationController, type: :request do
  it_behaves_like "registerable"
end
