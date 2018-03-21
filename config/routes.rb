Rails.application.routes.draw do
  constraints subdomain: 'api' do
    scope module: :api do
      namespace :v1 do
        post 'auth' => 'authentication#create'
        post 'register' => 'registration#create'
      end
    end
  end
end
