Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id/adoptable', to: 'pets#update_adoptable'
  patch '/pets/:id/pending', to: 'pets#update_adoptable'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/shelters/:shelter_id/pets', to: 'pets#index'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'reviews#edit'
  post '/shelters/:shelter_id', to: 'reviews#create'
  patch '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#update'
  delete '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#destroy'

  patch '/favorites/:pet_id', to: 'favorites_list#update'
  get '/favorites', to: 'favorites_list#index'
  delete '/favorites/:pet_id', to: 'favorites_list#destroy'
  delete '/favorites', to: 'favorites_list#destroy'

end
