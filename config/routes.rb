Rails.application.routes.draw do
  get 'l/:slug', to: 'link_redirects#show', as: :link_redirect
  resources :short_links, only: [:new, :create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
