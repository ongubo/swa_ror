Rails.application.routes.draw do
  get 'get-elections', to: "app#index"
  get 'get-elections/:election_id', to: "app#get_election"
  # get "demo/hello" => "your-controller#your/action"

  # get 'app/election'

  # Json Endpoints
  resources :elections
  get '/populate', to: 'elections#populate'
  

end
