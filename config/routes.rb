Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get '/items/new' => 'items#new', as: :new_item
  post '/items' => 'items#create'
  get '/items/:id' => 'items#show', as: :item

end
