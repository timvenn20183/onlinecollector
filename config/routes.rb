Rails.application.routes.draw do

    get '/', to: 'site#index'
    get '/items/', to: 'items#index'
    get 'fieldoptions', to: 'fieldoptions#index'
    get 'fieldoptions/:id', to: 'fieldoptions#show'
    get 'fieldoptions/:fieldoption/items', to: 'items#index'
    get 'itemfields', to: 'itemfields#index'
    get 'itemfields/:id', to: 'itemfields#show'
    get 'itemfields/:itemfield/items', to: 'items#index'
    get '/signin', to: 'site#signin'
    post '/signin_process', to: 'site#signin_process'
    get '/signup', to: 'site#signup'
    get '/signout', to: 'site#signout'
    post '/signup_process', to: 'site#signup_process'
    get '/activation', to: 'activation#index'
    get '/profile', to: 'site#profile'
    get '/items/new', to: 'items#new'
    get '/item/:slug', to: 'items#show'
    get '/item/:slug/edit', to: 'items#edit'
    post '/items', to: 'items#create'
    post '/items/update', to: 'items#update'

end
