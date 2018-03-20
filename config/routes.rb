Rails.application.routes.draw do
  # namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
  #   post 'auth' => 'authentication#create'
  # end

  constraints subdomain: 'api' do
    scope module: :api do
      namespace :v1 do
        post 'auth' => 'authentication#create'
        post 'register' => 'registration#create'
      end
    end
  end
end
