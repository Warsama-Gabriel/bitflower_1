Rails.application.routes.draw do

  devise_for :users

#   new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
#             user_session POST   /users/sign_in(.:format)       devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
#            user_password POST   /users/password(.:format)      devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)  devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
#                          PATCH  /users/password(.:format)      devise/passwords#update
#                          PUT    /users/password(.:format)      devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)        devise/registrations#cancel
#        user_registration POST   /users(.:format)               devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
#                          PATCH  /users(.:format)               devise/registrations#update
#                          PUT    /users(.:format)               devise/registrations#update
#                          DELETE /users(.:format)               devise/registrations#destroy
#                      root GET    /                              home#index
                 # profile GET    /you/profile(.:format)         welcome#index
                 #  search GET    /you/search(.:format)          welcome#search
                 # results GET    /you/results(.:format)         welcome#show
                 #     fav POST   /fav/:id(.:format)             welcome#fav
                 #  update DELETE /fav/update/:id(.:format)      welcome#update
                 # destroy DELETE /fav/:id(.:format)             welcome#destroy


    root :to => "home#index"

  get '/simplesearch' => 'welcome#simplesearch'

  get '/you/profile',   :to =>  'welcome#index',  :as => :profile
  post '/you/tweets/:track_id',    :to =>  'welcome#tweet',  :as =>  :tweets
  get '/you/search',     :to => 'welcome#search',  :as => :search #search page
  get '/you/results',   :to => 'welcome#show',    :as => :results #results page
  get '/you/soundcloud',  :to => 'welcome#soundcloud', :as => :soundcloud
  post '/fav/:id',      :to => 'welcome#fav',      :as => :fav
  delete '/fav/update/:id',  :to => 'welcome#update',  :as => :update
  delete '/fav/:id',    :to => 'welcome#destroy',  :as => :destroy

end
