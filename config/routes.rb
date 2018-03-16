Rails.application.routes.draw do
  # constraints subdomain: 'api' do
  #   scope module: 'api' do
  #     namespace :v1 do
  #       post 'auth' => 'authentication#create'
  #       post 'register' => 'registration#create'
  #     end
  #   end
  # end

  # namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
  #   post 'auth' => 'authentication#create'
  # end

  scope module: :api do
    namespace :v1 do
      post 'auth' => 'authentication#create'
      post 'register' => 'registration#create'
    end
  end
end
