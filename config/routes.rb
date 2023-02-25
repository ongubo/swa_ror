Rails.application.routes.draw do
  get 'get-elections', to: "app#index"
  get 'get-elections/:election_id', to: "app#get_election"
  get 'new-elections', to: "app#new"


  # Json Endpoints
  resources :elections
  get '/populate', to: 'elections#populate'
  

end
