Rails.application.routes.draw do
  get '' => 'welcome#index'

  resources :people
  resources :electors

  get 'zone_candidates/new' => 'zone_candidates#new', as: 'new_zone_candidates'
  post 'zone_candidates/' => 'zone_candidates#create'
  get 'zone_candidates/show/:id' => 'zone_candidates#show', as: 'zone_candidate'
  get 'zone_candidates' => 'zone_candidates#index'

  get 'parties/show_image' => 'parties#show_image'
  resources :parties

  get 'candidates/show_image' => 'candidates#show_image'
  resources :candidates


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
