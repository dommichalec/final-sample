Rails.application.routes.draw do
  root    "static_pages#home"
  get     "/help",        to: "static_pages#help",            as: 'help'
  get     "/about",       to: "static_pages#about",           as: 'about'
  get     "/contact",     to: "static_pages#contact",         as: 'contact'
  get     "/signup",      to: "users#new",                    as: 'signup'
  post    "/signup",      to: 'users#create'
  get     "/signin",      to: 'sessions#new',                 as: 'signin'
  post    "/signin",      to: 'sessions#create'
  delete  "/signout",     to: 'sessions#destroy',             as: 'signout'
  resources :users do
    member do
      patch :archive # /users/:id/archive, to: users#archive , as: archive_user
      patch :unarchive # /users/:id/unarchive to: users#unarchive, as: unarchive_user
    end
  end
  resources :microposts, only: [:create, :destroy]
end
