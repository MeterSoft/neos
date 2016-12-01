Neos::Application.routes.draw do
  resources :purchases do
    member do
      put :purchase
    end
  end
  resources :baskets do
    collection do
      post :attach_promo_code
      get :finish
    end
    member do
      delete :remove_promo_code
    end
  end
  resources :creditcards

  root to: "purchases#index"
end
