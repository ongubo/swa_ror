Rails.application.routes.draw do
  get 'get-elections', to: "app#index"
  get 'get-election', to: "app#election"
  # get "demo/hello" => "your-controller#your/action"

  # get 'app/election'

  # Json Endpoints
  resources :elections
  get '/populate', to: 'elections#populate'
  

end
