Rails.application.routes.draw do
  get '' => 'welcome#index', as: 'index'
  get 'estatisticas' => 'welcome#estatisticas', as: 'estatisticas'
  get 'resultados' => 'welcome#resultados', as: 'resultados'
  get 'votar' => 'welcome#votar', as: 'votar'
  post 'votar' => 'welcome#create_voto'
  post 'check' => 'welcome#check_elector'
  post 'resultados' => 'welcome#resultados'
  get 'cand_inst_sex' => 'welcome#cand_inst_sex', as: 'cand_inst_sex'
  get 'cand_per_party' => 'welcome#cand_per_party', as: 'cand_per_party'
  get 'cand_per_region' => 'welcome#cand_per_region', as: 'cand_per_region'
  get 'cand_per_state' => 'welcome#cand_per_state', as: 'cand_per_state'
  get 'global_participation' => 'welcome#global_participation', as: 'global_participation'
  get 'participation_per_region' => 'welcome#participation_per_region', as: 'participation_per_region'
  get 'participation_per_state' => 'welcome#participation_per_state', as: 'participation_per_state'
  get 'votes_per_party' => 'welcome#votes_per_party', as: 'votes_per_party'

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
