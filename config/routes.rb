Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :sales
  end
end
